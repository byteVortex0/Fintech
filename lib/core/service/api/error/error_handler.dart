import 'package:dio/dio.dart';
import 'api_result.dart';
import 'error_model.dart';
import 'error_mapper.dart';
import 'error_logger.dart';
import 'user_friendly_messages.dart';

/// Handles all errors from network requests and converts them to friendly messages
///
/// Maps Dio exceptions → error categories → user-friendly messages
/// Handles HTTP status codes (400, 401, 403, 404, 429, 5xx, etc.)
/// Provides retry logic for retryable errors
class ErrorHandler {
  static Future<Failure> handle(dynamic error) async {
    if (error is DioException) {
      return await _handleDioError(error);
    } else if (error is FormatException) {
      return Failure(ErrorModel.simple(UserFriendlyMessages.formatError));
    } else {
      return Failure(ErrorModel.simple(UserFriendlyMessages.unknownError));
    }
  }

  static Future<Failure> _handleDioError(DioException error) async {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Failure(
          ErrorModel(
            userMessage: UserFriendlyMessages.connectionTimeout,
            technicalMessage: 'Request timeout: ${error.type.toString()}',
            errorCode: 'TIMEOUT_ERROR',
            category: ErrorCategory.network,
            isRetryable: true,
          ),
        );

      case DioExceptionType.connectionError:
        return Failure(
          ErrorModel(
            userMessage: UserFriendlyMessages.noInternet,
            technicalMessage: 'Connection error: ${error.message}',
            errorCode: 'NETWORK_ERROR',
            category: ErrorCategory.network,
            isRetryable: true,
          ),
        );

      case DioExceptionType.cancel:
        return Failure(
          ErrorModel.simple(UserFriendlyMessages.requestCancelled),
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.unknown:
      default:
        return Failure(ErrorModel.simple(UserFriendlyMessages.unknownError));
    }
  }

  static Failure _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    // Log the error with full context
    final dataStr = data?.toString() ?? '';
    final truncatedData = dataStr.length > 500
        ? dataStr.substring(0, 500)
        : dataStr;

    ErrorLogger.logError(
      message: 'Bad response from server',
      technicalMessage: 'HTTP $statusCode - ${error.message}',
      statusCode: statusCode,
      errorCode: 'BAD_RESPONSE',
      category: ErrorMapper.categorizeByStatus(statusCode),
      error: error,
      extra: {'response_data': truncatedData},
    );

    try {
      final category = ErrorMapper.categorizeByStatus(statusCode);
      final isRetryable = ErrorMapper.isRetryableByStatus(statusCode);
      final userMessage = _getUserMessageForStatus(statusCode);

      if (data is Map<String, dynamic>) {
        // Try to extract server error message
        final serverMessage = data['status_message'] ?? data['message'];
        final errorCode = data['error_code'] ?? 'SERVER_ERROR';

        return Failure(
          ErrorModel(
            userMessage: userMessage,
            technicalMessage:
                serverMessage ?? 'HTTP $statusCode - ${error.message}',
            statusCode: statusCode,
            errorCode: errorCode,
            category: category,
            isRetryable: isRetryable,
          ),
        );
      } else if (data is String) {
        return Failure(
          ErrorModel(
            userMessage: userMessage,
            technicalMessage: data,
            statusCode: statusCode,
            errorCode: 'BAD_RESPONSE',
            category: category,
            isRetryable: isRetryable,
          ),
        );
      } else {
        return Failure(
          ErrorModel(
            userMessage: userMessage,
            technicalMessage: 'Unexpected response format',
            statusCode: statusCode,
            errorCode: 'PARSE_ERROR',
            category: ErrorCategory.parsing,
            isRetryable: isRetryable,
          ),
        );
      }
    } catch (e) {
      return Failure(ErrorModel.simple(UserFriendlyMessages.parsingError));
    }
  }

  /// Maps HTTP status codes to user-friendly messages
  static String _getUserMessageForStatus(int? statusCode) {
    switch (statusCode) {
      case 400:
        return UserFriendlyMessages.badRequest;
      case 401:
        return UserFriendlyMessages.unauthorized;
      case 403:
        return UserFriendlyMessages.forbidden;
      case 404:
        return UserFriendlyMessages.notFound;
      case 408:
      case 429:
        return UserFriendlyMessages.tooManyRequests;
      case 500:
      case 502:
      case 503:
      case 504:
        return UserFriendlyMessages.serverError;
      default:
        return UserFriendlyMessages.unknownError;
    }
  }
}

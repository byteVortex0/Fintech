import 'package:dio/dio.dart';
import 'retry_helper.dart';
import 'api_result.dart';
import '../error/error_model.dart';

class ErrorHandler {
  static Future<Failure> handle(dynamic error) async {
    if (error is DioException) {
      return await _handleDioError(error);
    } else if (error is FormatException) {
      return Failure(const ErrorModel(message: "Data format error."));
    } else {
      return Failure(
        ErrorModel(message: "Unexpected error: ${error.toString()}"),
      );
    }
  }

  static Future<Failure> _handleDioError(DioException error) async {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        try {
          await RetryHelper.retryRequest(Dio(), error.requestOptions);
          return Failure(
            ErrorModel(
              message: "Request retried successfully after network issue.",
            ),
          );
        } catch (e) {
          return Failure(
            const ErrorModel(
              message: "Failed after retrying. Please check your connection.",
            ),
          );
        }

      case DioExceptionType.cancel:
        return Failure(const ErrorModel(message: "Request cancelled by user."));

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.unknown:
      default:
        return Failure(
          ErrorModel(message: error.message ?? "Unknown Dio error."),
        );
    }
  }

  static Failure _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    if (statusCode == 401) {
      return Failure(
        const ErrorModel(message: "Unauthorized. Token expired or invalid."),
      );
    }

    try {
      if (data is Map<String, dynamic>) {
        final errorModel = ErrorModel.fromJson(data);
        return Failure(errorModel);
      } else if (data is String) {
        return Failure(ErrorModel(message: data));
      } else {
        return Failure(ErrorModel(message: "Unexpected response format"));
      }
    } catch (e) {
      return Failure(ErrorModel(message: "Error parsing server response: $e"));
    }
  }
}

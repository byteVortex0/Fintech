import 'package:dio/dio.dart';

/// Categories for different types of errors
///
/// Used to classify errors and determine appropriate user messages,
/// retry behavior, and logging levels.
enum ErrorCategory {
  network, // Connection, timeout, network issues
  authentication, // 401, 403 - auth failures
  validation, // 400 - bad request, validation errors
  notFound, // 404 - resource not found
  rateLimited, // 429 - too many requests
  server, // 5xx - server errors
  parsing, // Data format, JSON parsing errors
  unknown, // Unknown/unclassified errors
}

/// Maps DioException types and HTTP status codes to ErrorCategory
///
/// This class centralizes error classification logic, making it easy to
/// determine error type and apply consistent handling across the app.
class ErrorMapper {
  /// Categorizes a DioException into an ErrorCategory
  static ErrorCategory categorizeError(DioException error) {
    if (error.type == DioExceptionType.badResponse) {
      final statusCode = error.response?.statusCode;
      return _categorizeByStatusCode(statusCode);
    }

    return _categorizeByType(error.type);
  }

  /// Maps HTTP status codes to error categories (public version)
  static ErrorCategory categorizeByStatus(int? statusCode) {
    return _categorizeByStatusCode(statusCode);
  }

  /// Maps HTTP status codes to error categories
  static ErrorCategory _categorizeByStatusCode(int? statusCode) {
    if (statusCode == null) return ErrorCategory.unknown;

    if (statusCode == 400) return ErrorCategory.validation;
    if (statusCode == 401) return ErrorCategory.authentication;
    if (statusCode == 403) return ErrorCategory.authentication;
    if (statusCode == 404) return ErrorCategory.notFound;
    if (statusCode == 429) return ErrorCategory.rateLimited;
    if (statusCode >= 500) return ErrorCategory.server;

    return ErrorCategory.unknown;
  }

  /// Maps DioExceptionType to error categories
  static ErrorCategory _categorizeByType(DioExceptionType type) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return ErrorCategory.network;

      case DioExceptionType.cancel:
        return ErrorCategory.unknown;

      case DioExceptionType.badResponse:
        // This shouldn't happen, handled above
        return ErrorCategory.unknown;

      case DioExceptionType.unknown:
      default:
        return ErrorCategory.unknown;
    }
  }

  /// Determines if an error is retryable based on its category
  static bool isRetryable(ErrorCategory category) {
    return category != ErrorCategory.authentication &&
        category != ErrorCategory.validation &&
        category != ErrorCategory.notFound;
  }

  /// Determines if an error is retryable based on HTTP status code
  static bool isRetryableByStatus(int? statusCode) {
    if (statusCode == null) return true;

    // Don't retry client errors (4xx) except for specific ones
    if (statusCode >= 400 && statusCode < 500) {
      // Retry rate limiting and request timeout
      return statusCode == 408 || statusCode == 429;
    }

    // Retry server errors (5xx) and network issues
    return true;
  }

  /// Get severity level for logging based on status code
  static String getSeverity(int? statusCode) {
    if (statusCode == null) return 'warning';

    if (statusCode >= 500) return 'error';
    if (statusCode >= 400) return 'warning';
    return 'info';
  }
}

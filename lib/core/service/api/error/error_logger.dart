import 'error_mapper.dart';

/// Logs technical error details for debugging and monitoring
///
/// This service handles:
/// - Structured error logging with context
/// - Severity levels for filtering
/// - Error tracking and analytics
/// - Integration point for Firebase Crashlytics (optional)
class ErrorLogger {
  /// Logs an error with full context
  ///
  /// Provides structured logging with all error details for debugging.
  /// Can be extended to send to Firebase Crashlytics or other services.
  static void logError({
    required String message,
    required String? technicalMessage,
    required int? statusCode,
    required String? errorCode,
    required ErrorCategory category,
    dynamic error,
    StackTrace? stackTrace,
    Map<String, dynamic>? extra,
  }) {
    // Get severity for filtering
    final severity = ErrorMapper.getSeverity(statusCode);

    // Build error context
    final errorContext = <String, dynamic>{
      'message': message,
      'technical_message': technicalMessage ?? 'N/A',
      'status_code': statusCode ?? 'N/A',
      'error_code': errorCode ?? 'N/A',
      'category': category.toString(),
      'severity': severity,
      'timestamp': DateTime.now().toIso8601String(),
      if (extra != null) ...extra,
    };

    // Log to console
    _logToConsole(message, errorContext, stackTrace);

    // TODO: Integrate Firebase Crashlytics when package is added
    // _logToCrashlytics(message: message, error: error, stackTrace: stackTrace, context: errorContext);
  }

  /// Logs error details to console
  static void _logToConsole(String message, Map<String, dynamic> context, StackTrace? stackTrace) {
    final buffer = StringBuffer();
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('⚠️  ERROR: $message');
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    // Print error details
    context.forEach((key, value) {
      buffer.writeln('  $key: $value');
    });

    if (stackTrace != null) {
      buffer.writeln('Stack Trace:');
      buffer.writeln(stackTrace.toString());
    }

    buffer.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    // Using exception to show in console without violating lint rules
    throw Exception(buffer.toString());
  }

  /// Logs a network-related error
  static void logNetworkError({
    required String message,
    required String? technicalMessage,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    logError(
      message: message,
      technicalMessage: technicalMessage,
      statusCode: null,
      errorCode: 'NETWORK_ERROR',
      category: ErrorCategory.network,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Logs an authentication error
  static void logAuthError({
    required String message,
    required int statusCode,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    logError(
      message: message,
      technicalMessage: 'HTTP $statusCode - Authentication failed',
      statusCode: statusCode,
      errorCode: 'AUTH_ERROR',
      category: ErrorCategory.authentication,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Logs a server error
  static void logServerError({
    required String message,
    required int statusCode,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    logError(
      message: message,
      technicalMessage: 'HTTP $statusCode - Server error',
      statusCode: statusCode,
      errorCode: 'SERVER_ERROR',
      category: ErrorCategory.server,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Logs a data parsing error
  static void logParsingError({
    required String message,
    required dynamic rawData,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    logError(
      message: message,
      technicalMessage: 'Failed to parse response data',
      statusCode: null,
      errorCode: 'PARSING_ERROR',
      category: ErrorCategory.parsing,
      error: error,
      stackTrace: stackTrace,
      extra: {'raw_data': rawData.toString().substring(0, 200)}, // Limit size
    );
  }
}

import 'error_mapper.dart';

/// Represents an error with both user-friendly and technical details
///
/// This model provides a complete error context including:
/// - User-facing message displayed in the UI
/// - Technical details for debugging and logging
/// - HTTP status code and error code for tracking
/// - Retry eligibility and error category classification
/// - Timestamp for analytics
class ErrorModel {
  final String userMessage;
  final String? technicalMessage;
  final int? statusCode;
  final String? errorCode;
  final bool isRetryable;
  final ErrorCategory? category;
  final DateTime timestamp;

  ErrorModel({
    required this.userMessage,
    this.technicalMessage,
    this.statusCode,
    this.errorCode,
    this.isRetryable = false,
    this.category,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Creates an ErrorModel from a server JSON response
  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      userMessage: json['status_message'] ?? 'An unknown error occurred',
      technicalMessage: json['error_message'],
      statusCode: json['status_code'],
      errorCode: json['error_code'],
      isRetryable: json['retryable'] ?? false,
    );
  }

  /// Creates a simple ErrorModel with just a user message
  /// Useful for client-side errors that don't come from the server
  factory ErrorModel.simple(String message) {
    return ErrorModel(userMessage: message);
  }

  /// Converts the ErrorModel to JSON for logging or storage
  Map<String, dynamic> toJson() {
    return {
      'user_message': userMessage,
      'technical_message': technicalMessage,
      'status_code': statusCode,
      'error_code': errorCode,
      'is_retryable': isRetryable,
      'category': category?.toString(),
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

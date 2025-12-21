/// User-friendly error messages displayed to app users
///
/// This class contains all error messages that users see in the app.
/// These are conversational, actionable, and non-technical.
/// Organized by error category for easy management.
class UserFriendlyMessages {
  // Network connectivity errors
  static const String noInternet = 'No internet connection. Please check your WiFi or mobile data.';

  static const String connectionTimeout = 'Connection taking too long. Please try again.';

  static const String sendTimeout = 'Request took too long to send. Please try again.';

  static const String receiveTimeout = 'Response took too long to load. Please try again.';

  static const String connectionLost = 'Connection lost. Please check your internet and try again.';

  // Authentication errors
  static const String unauthorized = 'Your session has expired. Please log in again.';

  static const String forbidden = "You don't have permission to perform this action.";

  // Validation errors
  static const String badRequest = 'Invalid request. Please check your input and try again.';

  // Resource not found
  static const String notFound = 'The requested information was not found. Please try again.';

  // Rate limiting
  static const String tooManyRequests = 'Too many requests. Please wait a moment and try again.';

  // Server errors
  static const String serverError = 'Server error. Please try again later.';

  static const String serviceUnavailable =
      'Service is temporarily unavailable. Please try again later.';

  // Data format errors
  static const String formatError = 'Data format error. Please try again.';

  static const String parsingError = 'Invalid data received. Please try again.';

  static const String unexpectedFormat = 'Unexpected response format. Please try again.';

  // Generic/unknown errors
  static const String unknownError = 'Something went wrong. Please try again.';

  static const String genericError =
      'An error occurred. Please check your connection and try again.';

  // User action errors
  static const String requestCancelled = 'Request was cancelled.';

  static const String emptyResponse = 'No data available. Please try again.';

  // Custom error scenarios
  static const String invalidCredentials = 'Invalid email or password. Please try again.';

  static const String userNotFound = 'User not found. Please check and try again.';

  static const String accountLocked = 'Account is locked. Please try again later.';

  // Success messages
  static const String success = 'Operation completed successfully.';

  // Retry-related
  static const String retryFailed =
      'Multiple retry attempts failed. Please check your connection and try again.';

  static const String pleaseTryAgain = 'Please try again.';
}

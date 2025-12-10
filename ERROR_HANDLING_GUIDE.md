# Error Handling Best Practices Guide

**Last Updated**: December 10, 2025
**Purpose**: Comprehensive guide for user-friendly error messages and proper error handling
**Status**: Design document for implementation review

---

## 📋 Executive Summary

Current state shows technical errors to users. This guide improves error handling by:
- ✅ Converting technical errors to friendly messages
- ✅ Separating user messages from technical logs
- ✅ Proper HTTP status code handling (400, 403, 404, 429, 500, 503)
- ✅ Consistent error responses across the app
- ✅ Better debugging for developers (technical info in logs)

---

## 🎯 Problem Statement

### Current Issues

**What Users See:**
```
❌ "Error parsing server response: {statusCode: 500, data: null}"
❌ "Unexpected response format"
❌ "Error parsing server response: Invalid JSON"
❌ "Connection taking too long. Please try again."
```

**Why It's Bad:**
- Technical jargon confuses users
- Not actionable (user doesn't know what to do)
- Unprofessional appearance
- No consistent experience across features

### Goals

**What Users Should See:**
```
✅ "Server is currently unavailable. Please try again later."
✅ "Invalid data format. Please try again."
✅ "Your request took too long. Please check your connection."
✅ "Too many requests. Please wait a moment and try again."
```

**Benefits:**
- Clear and actionable
- Professional appearance
- Consistent across app
- User feels reassured, not panicked

---

## 🏗️ Architecture Overview

### Current Error Flow

```
API Response
    ↓
DioException
    ↓
ErrorHandler.handle()
    ↓
ErrorModel(message)
    ↓
UI (shows raw message)
```

### Proposed Error Flow

```
API Response
    ↓
DioException
    ↓
ErrorHandler.handle()
    ↓
ErrorModel(
  userMessage: "Friendly message",
  errorCode: 500,
  technicalMessage: "Technical details for logging"
)
    ↓
UI (shows userMessage)
Logging (saves technicalMessage)
```

---

## 📊 Error Categories & Mappings

### 1. Network Errors

| Error | User Message | Technical Details |
|-------|--------------|------------------|
| No Internet | "No internet connection. Please check your WiFi or mobile data." | ConnectionError |
| Connection Timeout | "Connection taking too long. Please try again." | connectionTimeout |
| Send Timeout | "Request took too long to send. Please try again." | sendTimeout |
| Receive Timeout | "Response took too long. Please try again." | receiveTimeout |
| Connection Lost | "Connection lost. Please check your internet." | connectionError |

### 2. HTTP Status Codes

| Code | User Message | Technical Details |
|------|--------------|------------------|
| 400 | "Invalid request. Please check your input and try again." | BadRequestException |
| 401 | "Your session has expired. Please log in again." | UnauthorizedException |
| 403 | "You don't have permission to perform this action." | ForbiddenException |
| 404 | "The requested data was not found." | NotFoundException |
| 429 | "Too many requests. Please wait a moment and try again." | TooManyRequestsException |
| 500 | "Server error. Please try again later." | ServerException |
| 503 | "Service unavailable. Please try again later." | ServiceUnavailableException |

### 3. Data Format Errors

| Error | User Message | Technical Details |
|-------|--------------|------------------|
| Invalid JSON | "Data format error. Please try again." | FormatException |
| Parsing Error | "Invalid data received. Please try again." | ParsingException |
| Unexpected Format | "Unexpected response format. Please try again." | UnexpectedFormatException |

### 4. User Action Errors

| Error | User Message | Technical Details |
|-------|--------------|------------------|
| Request Cancelled | "Request was cancelled." | CancelException |
| Empty Response | "No data available. Please try again." | EmptyResponseException |

### 5. Unknown/Generic Errors

| Error | User Message | Technical Details |
|-------|--------------|------------------|
| Unknown Error | "Something went wrong. Please try again." | UnknownException |

---

## 💾 Data Model Design

### Enhanced ErrorModel

```dart
class ErrorModel {
  /// Message displayed to users (friendly, non-technical)
  final String userMessage;

  /// Technical message for logging/debugging
  final String? technicalMessage;

  /// HTTP status code (if applicable)
  final int? statusCode;

  /// Error code for tracking specific errors
  final String? errorCode;

  /// Raw response data (for debugging)
  final dynamic rawData;

  /// Timestamp for logging
  final DateTime timestamp;

  /// Whether to show retry button
  final bool isRetryable;
}
```

### ErrorCategory Enum

```dart
enum ErrorCategory {
  network,           // Connection, timeout, etc.
  authentication,    // 401, 403, etc.
  validation,        // 400 - bad request
  notFound,          // 404 - resource not found
  rateLimited,       // 429 - too many requests
  server,            // 500, 503 - server errors
  parsing,           // Data format errors
  unknown,           // Unknown/generic errors
}
```

---

## 🔄 Error Handling Flow

### Step 1: Handle Different Error Types

```
DioException
├── connectionTimeout → "Connection taking too long..."
├── sendTimeout → "Request took too long to send..."
├── receiveTimeout → "Response took too long..."
├── connectionError → "No internet connection..."
├── badResponse → Parse HTTP status code
│   ├── 400 → "Invalid request..."
│   ├── 401 → "Session expired..."
│   ├── 403 → "Permission denied..."
│   ├── 404 → "Data not found..."
│   ├── 429 → "Too many requests..."
│   ├── 5xx → "Server error..."
│   └── Other → "Unexpected server response..."
├── cancel → "Request was cancelled."
└── unknown → "Something went wrong..."

FormatException → "Data format error..."
Other Exception → "Something went wrong..."
```

### Step 2: Log Technical Details

```dart
// Always log technical info for debugging
logger.error(
  'API Error',
  error: technicalMessage,
  stackTrace: stackTrace,
  extra: {
    'statusCode': statusCode,
    'errorCode': errorCode,
    'timestamp': timestamp,
    'rawData': rawData,
  }
);
```

### Step 3: Return to UI with User Message

```dart
// UI only shows userMessage
// Never shows technical details
ErrorModel(
  userMessage: "Server error. Please try again later.",
  technicalMessage: "HTTP 500 - Internal Server Error",
  statusCode: 500,
  isRetryable: true,
)
```

### Step 4: Show in UI

```dart
// In Cubit/BLoC
if (error != null) {
  // Show user message (friendly)
  showSnackBar(error.userMessage);

  // Show retry button if retryable
  if (error.isRetryable) {
    showRetryButton();
  }
}
```

---

## 📁 File Structure

### Current Files
```
lib/core/service/api/error/
├── error_handler.dart      ← Main handler (IMPROVE)
├── error_model.dart        ← Data model (ENHANCE)
├── api_result.dart         ← Result wrapper
└── retry_helper.dart       ← Retry logic
```

### New Files to Create
```
lib/core/service/api/error/
├── error_handler.dart              ← IMPROVE (existing)
├── error_model.dart                ← ENHANCE (existing)
├── user_friendly_messages.dart     ← NEW (friendly message constants)
├── error_mapper.dart               ← NEW (maps errors to categories)
└── error_logger.dart               ← NEW (logs technical details)
```

---

## 🛠️ Implementation Details

### File 1: user_friendly_messages.dart

```dart
/// Constants for user-friendly error messages
class UserFriendlyMessages {
  // Network Errors
  static const String noInternet =
    'No internet connection. Please check your WiFi or mobile data.';

  static const String connectionTimeout =
    'Connection taking too long. Please try again.';

  static const String sendTimeout =
    'Request took too long to send. Please try again.';

  static const String receiveTimeout =
    'Response took too long. Please try again.';

  // Authentication
  static const String unauthorized =
    'Your session has expired. Please log in again.';

  static const String forbidden =
    "You don't have permission to perform this action.";

  // Validation
  static const String badRequest =
    'Invalid request. Please check your input and try again.';

  // Not Found
  static const String notFound =
    'The requested data was not found.';

  // Rate Limiting
  static const String tooManyRequests =
    'Too many requests. Please wait a moment and try again.';

  // Server Errors
  static const String serverError =
    'Server error. Please try again later.';

  static const String serviceUnavailable =
    'Service unavailable. Please try again later.';

  // Data Format
  static const String formatError =
    'Data format error. Please try again.';

  static const String parsingError =
    'Invalid data received. Please try again.';

  // Generic
  static const String unknownError =
    'Something went wrong. Please try again.';

  // Actions
  static const String requestCancelled =
    'Request was cancelled.';

  static const String emptyResponse =
    'No data available. Please try again.';
}
```

### File 2: error_mapper.dart

```dart
/// Maps DioException types and HTTP status codes to error categories
class ErrorMapper {
  static ErrorCategory categorizeError(DioException error) {
    if (error.type == DioExceptionType.badResponse) {
      final statusCode = error.response?.statusCode;
      return _categorizeByStatusCode(statusCode);
    }

    return _categorizeByType(error.type);
  }

  static ErrorCategory _categorizeByStatusCode(int? statusCode) {
    if (statusCode == null) return ErrorCategory.unknown;

    if (statusCode == 400) return ErrorCategory.validation;
    if (statusCode == 401 || statusCode == 403)
      return ErrorCategory.authentication;
    if (statusCode == 404) return ErrorCategory.notFound;
    if (statusCode == 429) return ErrorCategory.rateLimited;
    if (statusCode >= 500) return ErrorCategory.server;

    return ErrorCategory.unknown;
  }

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
        return ErrorCategory.unknown;

      case DioExceptionType.unknown:
      default:
        return ErrorCategory.unknown;
    }
  }
}

enum ErrorCategory {
  network,
  authentication,
  validation,
  notFound,
  rateLimited,
  server,
  parsing,
  unknown,
}
```

### File 3: error_logger.dart

```dart
/// Logs technical error details for debugging
class ErrorLogger {
  static void logError({
    required String message,
    required String? technicalMessage,
    required int? statusCode,
    required String? errorCode,
    dynamic error,
    StackTrace? stackTrace,
    Map<String, dynamic>? extra,
  }) {
    // Log to console/file/analytics
    print('⚠️ ERROR: $message');
    print('Technical: $technicalMessage');
    print('Status Code: $statusCode');
    print('Error Code: $errorCode');
    if (stackTrace != null) {
      print('Stack Trace: $stackTrace');
    }

    // In production, send to crash reporting service
    // FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }
}
```

### File 4: Enhanced error_handler.dart

```dart
/// Updated error handler that maps errors to user-friendly messages
class ErrorHandler {
  static Future<Failure> handle(dynamic error) async {
    if (error is DioException) {
      return await _handleDioError(error);
    } else if (error is FormatException) {
      return _handleFormatException(error);
    } else {
      return _handleUnknownError(error);
    }
  }

  static Future<Failure> _handleDioError(DioException error) async {
    final category = ErrorMapper.categorizeError(error);

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Failure(ErrorModel(
          userMessage: UserFriendlyMessages.connectionTimeout,
          technicalMessage: error.toString(),
          errorCode: 'CONNECTION_TIMEOUT',
          isRetryable: true,
        ));

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      // ... handle other cases
    }
  }

  static Failure _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final userMessage = _getUserMessageForStatus(statusCode);

    return Failure(ErrorModel(
      userMessage: userMessage,
      technicalMessage: error.response?.data?.toString(),
      statusCode: statusCode,
      isRetryable: _isRetryableStatus(statusCode),
    ));
  }

  static String _getUserMessageForStatus(int? statusCode) {
    switch (statusCode) {
      case 400: return UserFriendlyMessages.badRequest;
      case 401: return UserFriendlyMessages.unauthorized;
      case 403: return UserFriendlyMessages.forbidden;
      case 404: return UserFriendlyMessages.notFound;
      case 429: return UserFriendlyMessages.tooManyRequests;
      case 500: return UserFriendlyMessages.serverError;
      case 503: return UserFriendlyMessages.serviceUnavailable;
      default: return UserFriendlyMessages.unknownError;
    }
  }

  static bool _isRetryableStatus(int? statusCode) {
    // Retry on network-like errors and server errors
    return statusCode == null ||
           statusCode == 408 ||
           statusCode == 429 ||
           statusCode == 500 ||
           statusCode == 503;
  }
}
```

---

## 🎨 UI Integration

### In Cubit/BLoC

```dart
// Before (showing technical message)
emit(state.copyWith(error: 'Error parsing server response'));

// After (showing user message)
emit(state.copyWith(error: failure.errorModel.userMessage));
```

### In Widgets

```dart
// Show error to user
if (state.error != null) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(state.error!),  // User message only
      action: state.isRetryable
          ? SnackBarAction(
              label: 'Retry',
              onPressed: () => context.read<YourCubit>().retry(),
            )
          : null,
    ),
  );
}
```

---

## ✅ Benefits

### For Users
- ✅ Clear, actionable error messages
- ✅ Professional appearance
- ✅ Reduced confusion and frustration
- ✅ Know when to retry vs. when to contact support

### For Developers
- ✅ Technical details still available in logs
- ✅ Better error tracking and debugging
- ✅ Consistent error handling across app
- ✅ Easy to add new error types

### For Maintenance
- ✅ Centralized error message management
- ✅ Easy to update messages without code changes
- ✅ Better error categorization for analytics
- ✅ Reusable error handling patterns

---

## 🔄 Example Transformations

### Example 1: Network Error

**Before:**
```
Error parsing server response: Connection refused
```

**After:**
```
No internet connection. Please check your WiFi or mobile data.
[Retry button appears]
```

### Example 2: Server Error

**Before:**
```
HTTP Error 500: Internal Server Error
```

**After:**
```
Server error. Please try again later.
[Retry button appears]
```

### Example 3: Validation Error

**Before:**
```
Error parsing server response: {"error": "Invalid email format"}
```

**After:**
```
Invalid request. Please check your input and try again.
[Input highlighted, no retry button]
```

---

## 📝 Error Model Enhancements

### Current ErrorModel
```dart
class ErrorModel {
  final String message;
}
```

### Enhanced ErrorModel
```dart
class ErrorModel {
  /// User-friendly message displayed in UI
  final String userMessage;

  /// Technical message for logging
  final String? technicalMessage;

  /// HTTP status code
  final int? statusCode;

  /// Error code for tracking
  final String? errorCode;

  /// Category for analytics
  final ErrorCategory? category;

  /// Whether user can retry
  final bool isRetryable;

  /// Timestamp for logging
  final DateTime timestamp;

  /// Raw response data for debugging
  final dynamic rawData;
}
```

---

## 🎯 Testing Strategy

### Unit Tests

```dart
test('Maps 500 status to user message', () {
  final error = DioException.badResponse(500, ...);
  final failure = ErrorHandler.handle(error);

  expect(
    failure.errorModel.userMessage,
    equals(UserFriendlyMessages.serverError),
  );
});

test('500 error is retryable', () {
  final error = DioException.badResponse(500, ...);
  final failure = ErrorHandler.handle(error);

  expect(failure.errorModel.isRetryable, true);
});
```

### Widget Tests

```dart
testWidgets('Shows user message in snackbar', (tester) async {
  // Setup error state
  final error = UserFriendlyMessages.serverError;

  // Verify snackbar shows user message
  expect(find.text(error), findsOneWidget);

  // Verify retry button appears
  expect(find.byType(SnackBarAction), findsOneWidget);
});
```

---

## 📚 References

- Clean Code principles for error handling
- UX best practices for error messages
- User experience error messaging guidelines
- Flutter error handling patterns

---

**Last Updated**: December 10, 2025
**Document Owner**: Development Team
**Status**: Ready for implementation

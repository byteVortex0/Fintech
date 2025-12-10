import 'package:dio/dio.dart';
import 'package:fintech/core/service/api/error/error_handler.dart';
import 'package:fintech/core/service/api/error/error_mapper.dart';
import 'package:fintech/core/service/api/error/user_friendly_messages.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorHandler - Core Functionality', () {
    test('handles connection timeout exception', () async {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );

      final result = await ErrorHandler.handle(exception);

      expect(
        result.errorModel.userMessage,
        UserFriendlyMessages.connectionTimeout,
      );
      expect(result.errorModel.category, ErrorCategory.network);
      expect(result.errorModel.isRetryable, true);
      expect(result.errorModel.errorCode, 'TIMEOUT_ERROR');
    });

    test('handles connection error exception', () async {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionError,
        message: 'Network unreachable',
      );

      final result = await ErrorHandler.handle(exception);

      expect(result.errorModel.userMessage, UserFriendlyMessages.noInternet);
      expect(result.errorModel.category, ErrorCategory.network);
      expect(result.errorModel.isRetryable, true);
      expect(result.errorModel.errorCode, 'NETWORK_ERROR');
    });

    test('handles send timeout exception', () async {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.sendTimeout,
      );

      final result = await ErrorHandler.handle(exception);

      expect(
        result.errorModel.userMessage,
        UserFriendlyMessages.connectionTimeout,
      );
      expect(result.errorModel.isRetryable, true);
    });

    test('handles receive timeout exception', () async {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.receiveTimeout,
      );

      final result = await ErrorHandler.handle(exception);

      expect(
        result.errorModel.userMessage,
        UserFriendlyMessages.connectionTimeout,
      );
      expect(result.errorModel.category, ErrorCategory.network);
    });

    test('handles cancelled request exception', () async {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.cancel,
      );

      final result = await ErrorHandler.handle(exception);

      expect(
        result.errorModel.userMessage,
        UserFriendlyMessages.requestCancelled,
      );
    });

    test('handles FormatException', () async {
      final exception = FormatException('Invalid JSON');

      final result = await ErrorHandler.handle(exception);

      expect(result.errorModel.userMessage, UserFriendlyMessages.formatError);
    });

    test('handles unknown exception type', () async {
      final exception = Exception('Unknown error');

      final result = await ErrorHandler.handle(exception);

      expect(result.errorModel.userMessage, UserFriendlyMessages.unknownError);
    });

    test('error model has timestamp after handling', () async {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionError,
      );

      final result = await ErrorHandler.handle(exception);

      expect(result.errorModel.timestamp, isNotNull);
    });

    test('error model preserves technical message', () async {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionError,
        message: 'Specific network issue',
      );

      final result = await ErrorHandler.handle(exception);

      expect(
        result.errorModel.technicalMessage,
        contains('Specific network issue'),
      );
    });
  });
}

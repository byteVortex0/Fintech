import 'dart:async';
import 'package:dio/dio.dart';

class RetryHelper {
  static Future<Response<T>> retryRequest<T>(
    Dio dio,
    RequestOptions requestOptions, {
    int retries = 2,
    Duration delay = const Duration(seconds: 2),
  }) async {
    late Response<T> response;
    DioException? lastError;

    for (int attempt = 0; attempt <= retries; attempt++) {
      try {
        response = await dio.fetch<T>(requestOptions);
        return response;
      } catch (e) {
        if (e is DioException) {
          lastError = e;

          if (_isRetryable(e)) {
            if (attempt < retries) {
              await Future.delayed(delay);
              continue;
            }
          }
        }
        rethrow;
      }
    }

    throw lastError ?? DioException(requestOptions: requestOptions);
  }

  static bool _isRetryable(DioException e) {
    return e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout;
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../app/env_variables.dart';

class DioFactory {
  DioFactory._();

  static final instance = DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    const timeOut = Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut
        ..options.headers = {
          'x-cg-demo-api-key': EnvVariables.instance.coingeckoApiKey,
          'Accept': 'application/json',
        };

      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor() {
    if (kDebugMode) {
      // dio?.interceptors.add(PrettyDioLogger(request: false, compact: false));
    }

    // dio?.interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (options, handler) {
    //       final token = EnvVariables.instance.envToken;
    //       options.headers['Authorization'] = 'Bearer $token';

    //       return handler.next(options);
    //     },
    //     onError: (error, handler) async {
    //       return handler.next(error);
    //     },
    //   ),
    // );
  }
}

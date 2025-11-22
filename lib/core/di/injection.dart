import 'package:get_it/get_it.dart';

import '../service/api/dio_factory.dart';

GetIt sl = GetIt.instance;

void setupInjection() {
  _initCore();
  _home();
}

void _initCore() {
  final dio = DioFactory.getDio();
  // sl
  //   ..registerFactory<ThemeCubit>(() => ThemeCubit())
  //   ..registerLazySingleton<ApiService>(() => ApiService(dio));
}

void _home() {}

import 'package:get_it/get_it.dart';

import '../service/api/dio_factory.dart';

GetIt sl = GetIt.instance;

void setupInjection() {
  _initCore();
  _home();
}

void _initCore() {
  final dio = DioFactory.getDio();
  // TODO: Register more services as features are added for clarity
  // sl
  //   ..registerFactory<ThemeCubit>(() => ThemeCubit())
  //   ..registerLazySingleton<ApiService>(() => ApiService(dio));
}

// TODO: Register home feature dependencies here when feature is expanded
void _home() {}

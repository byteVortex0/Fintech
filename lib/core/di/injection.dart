import 'package:get_it/get_it.dart';

import '../service/api/dio_factory.dart';
import '../service/local_storage/theme_storage_service.dart';
import '../theme/theme_cubit.dart';

GetIt sl = GetIt.instance;

void setupInjection() {
  _initCore();
  _home();
}

void _initCore() {
  final dio = DioFactory.getDio();

  // Theme services
  sl.registerLazySingleton<ThemeStorageService>(() => ThemeStorageService());
  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sl()));

  // TODO: Register more services as features are added for clarity
  // sl.registerLazySingleton<ApiService>(() => ApiService(dio));
}

// TODO: Register home feature dependencies here when feature is expanded
void _home() {}

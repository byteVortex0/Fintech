import 'package:fintech/core/service/firebase/firebase_service.dart';
import 'package:fintech/features/register/data/repos/register_repo.dart';
import 'package:fintech/features/register/logic/register_cubit.dart';
import 'package:get_it/get_it.dart';

import '../service/api/dio_factory.dart';
import '../service/local_storage/theme_storage_service.dart';
import '../theme/theme_cubit.dart';

GetIt sl = GetIt.instance;

void setupInjection() {
  _initCore();
}

void _initCore() {
  final dio = DioFactory.getDio();
  sl.registerLazySingleton<FirebaseService>(() => FirebaseService());

  // Theme services
  sl.registerLazySingleton<ThemeStorageService>(() => ThemeStorageService());
  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sl()));

  // Register Feature
  sl.registerLazySingleton<RegisterRepo>(
    () => RegisterRepo(sl<FirebaseService>()),
  );
  sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl<RegisterRepo>()));

  // sl.registerLazySingleton<ApiService>(() => ApiService(dio));
}

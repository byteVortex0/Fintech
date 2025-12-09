import 'package:fintech/features/coin_details/data/repos/coin_details_repo.dart';
import 'package:fintech/features/coin_details/data/repos/coin_details_repo_impl.dart';
import 'package:fintech/core/service/firebase/firebase_service.dart';
import 'package:fintech/features/market/data/repo/market_coins_impl.dart';
import 'package:fintech/features/register/data/repos/register_repo.dart';
import 'package:fintech/features/register/logic/register_cubit.dart';
import 'package:fintech/features/login/data/repository/login_repository.dart';
import 'package:fintech/features/login/data/repository/biometric_repository.dart';
import 'package:fintech/features/login/data/services/biometric_enrollment_service.dart';
import 'package:fintech/features/login/presentation/cubit/login_cubit.dart';
import 'package:fintech/features/login/presentation/cubit/biometric_cubit.dart';
import 'package:fintech/features/login/presentation/cubit/auto_login_cubit.dart';
import 'package:get_it/get_it.dart';
import '../../features/coin_details/presentation/logic/chart_cubit/chart_cubit.dart';
import '../../features/coin_details/presentation/logic/coin_details_cubit/coin_details_cubit.dart';
import '../../features/market/data/repo/market_coins_repo.dart';
import '../../features/market/presentation/logic/cubit/market_coins_cubit.dart';
import '../service/api/api_service.dart';
import '../service/api/dio_factory.dart';
import '../service/local_storage/theme_storage_service.dart';
import '../theme/theme_cubit.dart';
import 'package:fintech/features/portfolio/data/repository/portfolio_repository.dart';
import 'package:fintech/features/portfolio/presentation/cubit/portfolio_cubit.dart';
import 'package:fintech/features/settings/data/repository/settings_repository.dart';
import 'package:fintech/features/settings/presentation/cubit/settings_cubit.dart';

import '../../features/home/data/repo/home_screen_repo.dart';
import '../../features/home/presentation/logic/cubit/home_cubit.dart';

GetIt sl = GetIt.instance;

void setupInjection() {
  _initCore();
  marketCoins();
  coinsDetails();
  registerFeature();
  homeScreen();
}

void _initCore() {
  final dio = DioFactory.getDio();
  sl.registerLazySingleton<FirebaseService>(() => FirebaseService());

  // Theme services
  sl.registerLazySingleton<ThemeStorageService>(() => ThemeStorageService());
  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sl()));

  // API Service
  sl.registerLazySingleton<ApiService>(() => ApiService(dio));

  // Login Repository
  sl.registerLazySingleton<LoginRepository>(() => LoginRepository());

  // Login Cubit
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl<LoginRepository>()));

  // Biometric Repository
  sl.registerLazySingleton<BiometricRepository>(() => BiometricRepository());

  // Biometric Cubit
  sl.registerFactory<BiometricCubit>(
    () => BiometricCubit(sl<BiometricRepository>()),
  );

  // Biometric Enrollment Service
  sl.registerLazySingleton<BiometricEnrollmentService>(
    () => BiometricEnrollmentService(),
  );

  // Auto Login Cubit
  sl.registerFactory<AutoLoginCubit>(
    () => AutoLoginCubit(sl<BiometricEnrollmentService>()),
  );

  // Portfolio Repository
  sl.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepository(sl<ApiService>()),
  );

  // Portfolio Cubit
  sl.registerFactory<PortfolioCubit>(
    () => PortfolioCubit(sl<PortfolioRepository>()),
  );

  // Settings Repository
  sl.registerLazySingleton<SettingsRepository>(() => SettingsRepository());

  // Settings Cubit
  sl.registerFactory<SettingsCubit>(
    () => SettingsCubit(sl<SettingsRepository>()),
  );
}

void marketCoins() {
  sl
    ..registerLazySingleton<MarketCoinsRepo>(() => MarketCoinsImpl(sl()))
    ..registerFactory<MarketCoinsCubit>(() => MarketCoinsCubit(sl()));
}

void coinsDetails() {
  sl
    ..registerLazySingleton<CoinDetailsRepo>(() => CoinDetailsRepoImpl(sl()))
    ..registerFactory<CoinDetailsCubit>(() => CoinDetailsCubit(sl()))
    ..registerFactory<ChartCubit>(() => ChartCubit(coinDetailsRepo: sl()));
}

void registerFeature() {
  // Register Feature
  sl.registerLazySingleton<RegisterRepo>(
    () => RegisterRepo(sl<FirebaseService>()),
  );
  sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl<RegisterRepo>()));

  // sl.registerLazySingleton<ApiService>(() => ApiService(dio));
}

void homeScreen() {
  sl
    ..registerLazySingleton(() => HomeScreenRepo(sl()))
    ..registerFactory<HomeCubit>(
      () => HomeCubit(sl<HomeScreenRepo>(), sl<SettingsRepository>()),
    );
}

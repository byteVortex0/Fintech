import 'package:fintech/features/coin_details/data/repos/get_coin_details_repo.dart';
import 'package:get_it/get_it.dart';

import '../../features/coin_details/presentation/logic/cubit/get_coin_details_cubit.dart';
import '../../features/market/data/repo/get_all_coins_markets_repo.dart';
import '../../features/market/presentation/logic/cubit/get_all_coins_markets_cubit.dart';
import '../service/api/api_service.dart';
import '../service/api/dio_factory.dart';
import '../service/local_storage/theme_storage_service.dart';
import '../theme/theme_cubit.dart';

GetIt sl = GetIt.instance;

void setupInjection() {
  _initCore();
  coinsMarket();
  coinsDetails();
}

void _initCore() {
  final dio = DioFactory.getDio();

  // Theme services
  sl.registerLazySingleton<ThemeStorageService>(() => ThemeStorageService());
  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sl()));
  sl.registerLazySingleton<ApiService>(() => ApiService(dio));
}

void coinsMarket() {
  sl
    ..registerLazySingleton(() => GetAllCoinsMarketsRepo(sl()))
    ..registerFactory(() => GetAllCoinsMarketsCubit(sl()));
}

void coinsDetails() {
  sl
    ..registerLazySingleton(() => GetCoinDetailsRepo(sl()))
    ..registerFactory(() => GetCoinDetailsCubit(sl()));
}

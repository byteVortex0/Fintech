import 'dart:developer';
import '../../../../core/service/api/api_service.dart';
import '../../../../core/service/api/error/api_result.dart';
import '../../../../core/service/api/error/error_handler.dart';
import '../models/home_screen_response.dart';
import '../models/global_response.dart';
import '../models/trending_response.dart';
import '../../../market/data/models/market_coin_response.dart';

class HomeScreenRepo {
  final ApiService apiService;

  HomeScreenRepo(this.apiService);

  Future<ApiResult<HomeScreenResponse>> getHomeScreen() async {
    try {
      log('[HomeScreenRepo] getHomeScreen called');
      final globalResult = await _getGlobalData();
      final trendingResult = await _getTrendingCoins();
      final topGainersResult = await _getTopGainers();

      if (globalResult is Failure<GlobalResponse>) {
        log('[HomeScreenRepo] globalResult failed');
        return ApiResult.failure(globalResult.errorModel);
      }

      if (trendingResult is Failure<TrendingResponse>) {
        log('[HomeScreenRepo] trendingResult failed');
        return ApiResult.failure(trendingResult.errorModel);
      }

      if (topGainersResult is Failure<List<MarketCoinResponse>>) {
        log('[HomeScreenRepo] topGainersResult failed');
        return ApiResult.failure(topGainersResult.errorModel);
      }

      final global = (globalResult as Success<GlobalResponse>).data;
      final trending = (trendingResult as Success<TrendingResponse>).data;
      final topGainers =
          (topGainersResult as Success<List<MarketCoinResponse>>).data;

      final response = HomeScreenResponse(
        global: global,
        trending: trending,
        topGainers: topGainers,
      );

      log('[HomeScreenRepo] getHomeScreen SUCCESS');
      return ApiResult.success(response);
    } catch (error) {
      log('[HomeScreenRepo] getHomeScreen ERROR: $error');
      final failure = await ErrorHandler.handle(error);
      return ApiResult.failure(failure.errorModel);
    }
  }

  Future<ApiResult<GlobalResponse>> _getGlobalData() async {
    try {
      log('[HomeScreenRepo] _getGlobalData called');
      final response = await apiService.getGlobal();
      log('[HomeScreenRepo] _getGlobalData SUCCESS');
      return ApiResult.success(response);
    } catch (error) {
      log('[HomeScreenRepo] _getGlobalData ERROR: $error');
      final failure = await ErrorHandler.handle(error);
      return ApiResult.failure(failure.errorModel);
    }
  }

  Future<ApiResult<TrendingResponse>> _getTrendingCoins() async {
    try {
      log('[HomeScreenRepo] _getTrendingCoins called');
      final response = await apiService.getSearchTrending();
      log('[HomeScreenRepo] _getTrendingCoins SUCCESS');
      return ApiResult.success(response);
    } catch (error) {
      log('[HomeScreenRepo] _getTrendingCoins ERROR: $error');
      final failure = await ErrorHandler.handle(error);
      return ApiResult.failure(failure.errorModel);
    }
  }

  Future<ApiResult<List<MarketCoinResponse>>> _getTopGainers() async {
    try {
      log('[HomeScreenRepo] _getTopGainers called');
      final response = await apiService.getAllCoinsMarkets(
        'usd',
        'market_cap_desc',
        10,
        1,
      );
      log('[HomeScreenRepo] _getTopGainers SUCCESS');
      return ApiResult.success(response);
    } catch (error) {
      log('[HomeScreenRepo] _getTopGainers ERROR: $error');
      final failure = await ErrorHandler.handle(error);
      return ApiResult.failure(failure.errorModel);
    }
  }
}

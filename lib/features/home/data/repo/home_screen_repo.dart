import '../../../../core/service/api/api_service.dart';
import '../../../../core/service/api/error/api_result.dart';
import '../../../../core/service/api/error/error_model.dart';
import '../models/home_screen_response.dart';
import '../models/global_response.dart';
import '../models/trending_response.dart';
import '../../../market/data/models/market_coin_response.dart';

class HomeScreenRepo {
  final ApiService apiService;

  HomeScreenRepo(this.apiService);

  Future<ApiResult<HomeScreenResponse>> getHomeScreen() async {
    try {
      final globalResult = await _getGlobalData();
      final trendingResult = await _getTrendingCoins();
      final topGainersResult = await _getTopGainers();

      if (globalResult is Failure<GlobalResponse>) {
        return ApiResult.failure(globalResult.errorModel);
      }

      if (trendingResult is Failure<TrendingResponse>) {
        return ApiResult.failure(trendingResult.errorModel);
      }

      if (topGainersResult is Failure<List<MarketCoinResponse>>) {
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

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorModel(message: error.toString()));
    }
  }

  Future<ApiResult<GlobalResponse>> _getGlobalData() async {
    try {
      final response = await apiService.getGlobal();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(
        ErrorModel(message: 'Failed to fetch global data: ${error.toString()}'),
      );
    }
  }

  Future<ApiResult<TrendingResponse>> _getTrendingCoins() async {
    try {
      final response = await apiService.getSearchTrending();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(
        ErrorModel(
          message: 'Failed to fetch trending coins: ${error.toString()}',
        ),
      );
    }
  }

  Future<ApiResult<List<MarketCoinResponse>>> _getTopGainers() async {
    try {
      final response = await apiService.getAllCoinsMarkets(
        'usd',
        'market_cap_desc',
        10,
        1,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(
        ErrorModel(message: 'Failed to fetch top gainers: ${error.toString()}'),
      );
    }
  }
}

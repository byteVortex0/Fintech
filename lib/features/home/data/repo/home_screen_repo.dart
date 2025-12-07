import 'package:fintech/core/service/api/api_service.dart';
import 'package:fintech/core/service/api/error/api_result.dart';

import 'package:fintech/core/service/api/error/error_model.dart';
import 'package:fintech/features/home/data/models/home_screen_response.dart';
import 'package:fintech/features/home/data/models/global_response.dart';
import 'package:fintech/features/home/data/models/trending_response.dart';
import 'package:fintech/features/market/data/models/market_coin_response.dart';

class HomeScreenRepo {
  final ApiService apiService;

  HomeScreenRepo(this.apiService);

  Future<ApiResult<HomeScreenResponse>> getHomeScreen() async {
    try {
      final results = await Future.wait([
        apiService.getGlobal(),
        apiService.getSearchTrending(),
        apiService.getAllCoinsMarkets('usd', 'market_cap_desc', 10, 1),
      ]);

      final global = results[0] as GlobalResponse;
      final trending = results[1] as TrendingResponse;
      final topGainers = results[2] as List<MarketCoinResponse>;

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
}

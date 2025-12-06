import 'package:fintech/core/service/api/error/api_result.dart';
import 'package:fintech/features/market/data/models/market_coin_request.dart';
import 'package:fintech/features/market/data/models/market_coin_response.dart';
import 'package:fintech/features/market/data/models/search_coin_response.dart';
import 'package:fintech/features/market/data/repo/market_coins_repo.dart';

import '../../../../core/service/api/api_service.dart';
import '../../../../core/service/api/error/error_model.dart';

class MarketCoinsImpl implements MarketCoinsRepo {
  ApiService apiService;

  MarketCoinsImpl(this.apiService);

  @override
  Future<ApiResult<List<MarketCoinResponse>>> getAllCoinsMarkets(
    MarketCoinRequest marketCoinRequest,
  ) async {
    try {
      final response = await apiService.getAllCoinsMarkets(
        marketCoinRequest.vsCurrency,
        marketCoinRequest.order,
        marketCoinRequest.perPage,
        marketCoinRequest.page,
      );

      return Success(response);
    } catch (e) {
      return Failure(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<ApiResult<List<SearchCoin>>> searchCoins(String query) async {
    try {
      final response = await apiService.searchCoin(query);
      return Success(response.coins);
    } catch (e) {
      return Failure(ErrorModel(message: e.toString()));
    }
  }
}

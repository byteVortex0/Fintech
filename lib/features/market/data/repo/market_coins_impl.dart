import 'dart:developer';
import '../../../../core/service/api/error/api_result.dart';
import '../../../../core/service/api/error/error_handler.dart';
import '../models/market_coin_request.dart';
import '../models/market_coin_response.dart';
import '../models/search_coin_response.dart';
import 'market_coins_repo.dart';

import '../../../../core/service/api/api_service.dart';

class MarketCoinsImpl implements MarketCoinsRepo {
  ApiService apiService;

  MarketCoinsImpl(this.apiService);

  @override
  Future<ApiResult<List<MarketCoinResponse>>> getAllCoinsMarkets(
    MarketCoinRequest marketCoinRequest,
  ) async {
    try {
      log('[MarketCoinsImpl] getAllCoinsMarkets called');
      final response = await apiService.getAllCoinsMarkets(
        marketCoinRequest.vsCurrency,
        marketCoinRequest.order,
        marketCoinRequest.perPage,
        marketCoinRequest.page,
      );

      log(
        '[MarketCoinsImpl] getAllCoinsMarkets SUCCESS: ${response.length} coins',
      );
      return Success(response);
    } catch (e) {
      log('[MarketCoinsImpl] getAllCoinsMarkets ERROR: $e');
      log('[MarketCoinsImpl] Error type: ${e.runtimeType}');
      final failure = await ErrorHandler.handle(e);
      log(
        '[MarketCoinsImpl] ErrorHandler returned friendly message: ${failure.errorModel.userMessage}',
      );
      return Failure(failure.errorModel);
    }
  }

  @override
  Future<ApiResult<List<SearchCoin>>> searchCoins(String query) async {
    try {
      log('[MarketCoinsImpl] searchCoins called with query: $query');
      final response = await apiService.searchCoin(query);
      log(
        '[MarketCoinsImpl] searchCoins SUCCESS: ${response.coins.length} results',
      );
      return Success(response.coins);
    } catch (e) {
      log('[MarketCoinsImpl] searchCoins ERROR: $e');
      final failure = await ErrorHandler.handle(e);
      log(
        '[MarketCoinsImpl] ErrorHandler returned friendly message: ${failure.errorModel.userMessage}',
      );
      return Failure(failure.errorModel);
    }
  }
}

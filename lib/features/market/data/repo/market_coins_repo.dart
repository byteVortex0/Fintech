import '../../../../core/service/api/error/api_result.dart';
import '../models/market_coin_request.dart';
import '../models/market_coin_response.dart';
import '../models/search_coin_response.dart';

abstract class MarketCoinsRepo {
  Future<ApiResult<List<MarketCoinResponse>>> getAllCoinsMarkets(
    MarketCoinRequest marketCoinRequest,
  );
  Future<ApiResult<List<SearchCoin>>> searchCoins(String query);
}

import 'package:fintech/core/service/api/api_service.dart';
import 'package:fintech/core/service/api/error/api_result.dart';
import 'package:fintech/features/market/data/models/market_coin_request.dart';
import 'package:fintech/features/market/data/models/market_coin_response.dart';

import '../../../../core/service/api/error/error_model.dart';

class GetAllCoinsMarketsRepo {
  ApiService apiService;

  GetAllCoinsMarketsRepo(this.apiService);

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
}

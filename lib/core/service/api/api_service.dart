import 'package:dio/dio.dart';
import 'package:fintech/features/market/data/models/market_coin_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../../features/coin_details/data/models/coin_details_remote_model.dart';
import '../../configs/api_endpoints.dart';
import 'package:fintech/features/home/data/models/global_response.dart';
import 'package:fintech/features/home/data/models/trending_response.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(ApiEndpoints.coinsMarkets)
  Future<List<MarketCoinResponse>> getAllCoinsMarkets(
    @Query('vs_currency') String vsCurrency,
    @Query('order') String order,
    @Query('per_page') int perPage,
    @Query('page') int page,
  );

  @GET(ApiEndpoints.coinDetails)
  Future<CoinDetailsRemoteModel> getCoinDetails(@Path('id') String id);


//!home features

    @GET(ApiEndpoints.global)
  Future<GlobalResponse> getGlobal();

 @GET(ApiEndpoints.searchTrending)
  Future<TrendingResponse> getSearchTrending();
}

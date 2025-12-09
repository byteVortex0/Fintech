import 'package:dio/dio.dart';
import '../../../features/coin_details/data/models/coins_chart_respose.dart';
import '../../../features/market/data/models/market_coin_response.dart';
import '../../../features/market/data/models/search_coin_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../../features/coin_details/data/models/coin_details_remote_model.dart';
import '../../configs/api_endpoints.dart';
import '../../../features/home/data/models/global_response.dart';
import '../../../features/home/data/models/trending_response.dart';
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

  /// Home screen endpoints
  @GET(ApiEndpoints.global)
  Future<GlobalResponse> getGlobal();

  @GET(ApiEndpoints.searchTrending)
  Future<TrendingResponse> getSearchTrending();

  /// Portfolio endpoints - Fetch cryptocurrency prices from CoinGecko
  /// Returns raw response with coin price data
  @GET(ApiEndpoints.holdingsPrices)
  Future<dynamic> getHoldingsPrices({
    @Query('ids') required String coinIds,
    @Query('vs_currencies') String currency = 'usd',
    @Query('include_24hr_change') bool include24h = true,
    @Query('x-cg-demo-api-key') required String apiKey,
  });

  @GET(ApiEndpoints.search)
  Future<SearchCoinResponse> searchCoin(@Query('query') String query);

  @GET(ApiEndpoints.chart)
  Future<CoinsChartResponse> chartCoin(
    @Path('id') String id,
    @Query('vs_currency') String vsCurrency,
    @Query('days') String days,
  );
}

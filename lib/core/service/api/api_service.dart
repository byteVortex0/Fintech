import 'package:dio/dio.dart';
import 'package:fintech/features/market/data/models/market_coin_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../../features/coin_details/data/models/coin_details_model.dart';
import '../../../features/coin_details/data/models/coin_details_remote_model.dart';

part 'api_service.g.dart';

const String baseUrl = 'https://api.coingecko.com/api/v3/';

@RestApi(baseUrl: baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('coins/markets')
  Future<List<MarketCoinResponse>> getAllCoinsMarkets(
    @Query('vs_currency') String vsCurrency,
    @Query('order') String order,
    @Query('per_page') int perPage,
    @Query('page') int page,
  );

  @GET('coins/{id}')
  Future<CoinDetailsRemoteModel> getCoinDetails(@Path('id') String id);
}

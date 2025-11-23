import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

const String baseUrl = 'https://api.coingecko.com/api/';

@RestApi(baseUrl: baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  //   @POST('v3/coins/bitcoin')
  //   Future<void> getAllPopularMovies(@Query("page") int page);
}

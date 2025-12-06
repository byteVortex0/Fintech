import 'package:fintech/features/home/data/models/global_response.dart';
import 'package:fintech/features/home/data/models/trending_response.dart';
import 'package:fintech/features/market/data/models/market_coin_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_screen_response.freezed.dart';


@freezed
abstract class HomeScreenResponse with _$HomeScreenResponse {
  const factory HomeScreenResponse({
    required GlobalResponse global,
    required TrendingResponse trending,
    required List<MarketCoinResponse> topGainers,
  }) = _HomeScreenResponse;
}
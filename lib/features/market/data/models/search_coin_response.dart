import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_coin_response.freezed.dart';
part 'search_coin_response.g.dart';

@freezed
sealed class SearchCoinResponse with _$SearchCoinResponse {
  const factory SearchCoinResponse({required List<SearchCoin> coins}) =
      _SearchCoinResponse;

  factory SearchCoinResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchCoinResponseFromJson(json);
}

@freezed
sealed class SearchCoin with _$SearchCoin {
  const factory SearchCoin({
    required String id,
    required String name,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'api_symbol') required String apiSymbol,
    required String symbol,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'market_cap_rank') int? marketCapRank,
    required String thumb,
    required String large,
  }) = _SearchCoin;

  factory SearchCoin.fromJson(Map<String, dynamic> json) =>
      _$SearchCoinFromJson(json);
}

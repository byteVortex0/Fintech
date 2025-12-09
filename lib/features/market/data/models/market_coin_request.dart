import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_coin_request.freezed.dart';
part 'market_coin_request.g.dart';

@freezed
abstract class MarketCoinRequest with _$MarketCoinRequest {
  const factory MarketCoinRequest({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'vs_currency') required String vsCurrency,
    required String order,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'per_page') required int perPage,
    required int page,
  }) = _MarketCoinRequest;

  factory MarketCoinRequest.fromJson(Map<String, dynamic> json) =>
      _$MarketCoinRequestFromJson(json);
}

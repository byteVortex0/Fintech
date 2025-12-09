import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_coin_response.freezed.dart';
part 'market_coin_response.g.dart';

@freezed
abstract class MarketCoinResponse with _$MarketCoinResponse {
  const factory MarketCoinResponse({
    required String id,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'name') required String name,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'market_cap_rank', defaultValue: 0) int? rank,
    // ignore: invalid_annotation_target
    @JsonKey(
      name: 'current_price',
      fromJson: _doubleFromJson,
      toJson: _doubleToJson,
      defaultValue: 0.0,
    )
    double? price,
    // ignore: invalid_annotation_target
    @JsonKey(
      name: 'price_change_percentage_24h',
      fromJson: _doubleFromJson,
      toJson: _doubleToJson,
      defaultValue: 0.0,
    )
    double? changePercent,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image', defaultValue: '') required String image,
  }) = _MarketCoinResponse;

  factory MarketCoinResponse.fromJson(Map<String, dynamic> json) =>
      _$MarketCoinResponseFromJson(json);
}

// Helper functions لتحويل null → double
double _doubleFromJson(dynamic value) {
  if (value == null) return 0.0;
  if (value is int) return value.toDouble();
  if (value is double) return value;
  return 0.0;
}

dynamic _doubleToJson(double? value) => value ?? 0.0;

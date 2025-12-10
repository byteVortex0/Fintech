import 'package:freezed_annotation/freezed_annotation.dart';

part 'global_response.freezed.dart';
part 'global_response.g.dart';

@freezed
abstract class GlobalResponse with _$GlobalResponse {
  const factory GlobalResponse({required GlobalData data}) = _GlobalResponse;

  factory GlobalResponse.fromJson(Map<String, dynamic> json) => _$GlobalResponseFromJson(json);
}

@freezed
abstract class GlobalData with _$GlobalData {
  const factory GlobalData({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'total_market_cap') required Map<String, double> totalMarketCap,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'total_volume') required Map<String, double> totalVolume,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'market_cap_percentage') required Map<String, double> marketCapPercentage,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'active_cryptocurrencies') required int activeCryptocurrencies,
  }) = _GlobalData;

  factory GlobalData.fromJson(Map<String, dynamic> json) => _$GlobalDataFromJson(json);
}

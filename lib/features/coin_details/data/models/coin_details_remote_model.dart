import 'package:freezed_annotation/freezed_annotation.dart';

part 'coin_details_remote_model.freezed.dart';
part 'coin_details_remote_model.g.dart';

@freezed
abstract class CoinDetailsRemoteModel with _$CoinDetailsRemoteModel {
  const factory CoinDetailsRemoteModel({
    required String id,
    required String symbol,
    required String name,
    @JsonKey(name: 'market_data') required Map<String, dynamic> marketData,
    required Map<String, dynamic> description,
    required Map<String, dynamic> image,
  }) = _CoinDetailsRemoteModel;

  factory CoinDetailsRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$CoinDetailsRemoteModelFromJson(json);
}

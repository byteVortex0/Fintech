import 'package:freezed_annotation/freezed_annotation.dart';

part 'coin_details_model.freezed.dart';

@freezed
class CoinDetailsModel with _$CoinDetailsModel {
  const factory CoinDetailsModel({
    required String name,
    required String price,
    required String pricePerUnit,
    required String changePercent,
    required bool isPositive,
    String? svgIconPath,
    required String currentPrice,
    required String marketCap,
    required String volume24h,
    required String availableSupply,
    required String maxSupply,
    required String description,
  }) = _CoinDetailsModel;
}

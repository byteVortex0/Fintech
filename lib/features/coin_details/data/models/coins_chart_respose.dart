import 'package:freezed_annotation/freezed_annotation.dart';

part 'coins_chart_respose.freezed.dart';

@freezed
abstract class CoinsChartResponse with _$CoinsChartResponse {
  const factory CoinsChartResponse({required List<List<double>> prices}) = _CoinsChartResponse;

  factory CoinsChartResponse.fromJson(Map<String, dynamic> json) {
    final pricesJson = json['prices'] as List<dynamic>?;

    final pricesList = pricesJson != null
        ? pricesJson.map<List<double>>((e) {
            final innerList = e as List<dynamic>;
            return innerList.map<double>((x) => (x as num).toDouble()).toList();
          }).toList()
        : <List<double>>[];

    return CoinsChartResponse(prices: pricesList);
  }
}

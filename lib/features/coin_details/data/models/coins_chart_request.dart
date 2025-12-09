import 'package:freezed_annotation/freezed_annotation.dart';

part 'coins_chart_request.freezed.dart';

@freezed
abstract class CoinsChartRequest with _$CoinsChartRequest {
  const factory CoinsChartRequest({
    required String id,
    @Default('usd') String vsCurrency,
    @Default('7') String days,
  }) = _CoinsChartRequest;
}

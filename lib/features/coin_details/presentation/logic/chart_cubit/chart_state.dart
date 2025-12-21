part of 'chart_cubit.dart';

@freezed
class ChartState with _$ChartState {
  const factory ChartState.loading() = _Loading;
  const factory ChartState.loaded(CoinsChartResponse data, String selectedPeriod) = _Loaded;
  const factory ChartState.error(String message) = _Error;
}

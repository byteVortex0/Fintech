import 'package:fintech/core/service/api/error/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/coins_chart_request.dart';
import '../../../data/models/coins_chart_respose.dart';
import '../../../data/repos/coin_details_repo.dart';

part 'chart_state.dart';
part 'chart_cubit.freezed.dart';

class ChartCubit extends Cubit<ChartState> {
  final CoinDetailsRepo coinDetailsRepo;

  ChartCubit({required this.coinDetailsRepo})
    : super(const ChartState.loading());

  Future<void> fetchChart({
    String period = '7d',
    required String coinId,
    String vsCurrency = 'usd',
  }) async {
    emit(const ChartState.loading());

    try {
      final periodToDays = {'1d': '1', '7d': '7', '1m': '30', '1y': '365'};
      final days = periodToDays[period] ?? '7';

      final chartResult = await coinDetailsRepo.getChartCoin(
        CoinsChartRequest(id: coinId, vsCurrency: vsCurrency, days: days),
      );

      chartResult.when(
        success: (chart) {
          emit(ChartState.loaded(chart, period));
        },
        failure: (error) {
          emit(ChartState.error(error.message));
        },
      );
    } catch (e) {
      emit(ChartState.error(e.toString()));
    }
  }
}

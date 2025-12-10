import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/service/api/error/api_result.dart';
import '../../../../../core/service/api/error/error_handler.dart';
import '../../../data/models/coins_chart_request.dart';
import '../../../data/models/coins_chart_respose.dart';
import '../../../data/repos/coin_details_repo.dart';

part 'chart_cubit.freezed.dart';
part 'chart_state.dart';

/// ChartCubit manages chart data with friendly error messages
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
          final failure = ErrorHandler.handle(error);
          failure.then((f) {
            emit(ChartState.error(f.errorModel.userMessage));
          });
        },
      );
    } catch (e) {
      final failure = await ErrorHandler.handle(e);
      emit(ChartState.error(failure.errorModel.userMessage));
    }
  }
}

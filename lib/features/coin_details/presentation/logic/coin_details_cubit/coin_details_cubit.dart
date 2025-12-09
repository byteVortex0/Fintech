import 'dart:developer';

import 'package:fintech/core/service/api/error/api_result.dart';
import 'package:fintech/features/coin_details/data/repos/coin_details_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/coin_details_model.dart';
import '../../../data/models/coins_chart_request.dart';
import '../../../data/models/coins_chart_respose.dart';

part 'coin_details_state.dart';
part 'coin_details_cubit.freezed.dart';

class CoinDetailsCubit extends Cubit<CoinDetailsState> {
  CoinDetailsCubit(this.coinDetailsRepo) : super(CoinDetailsState.loading());

  final CoinDetailsRepo coinDetailsRepo;

  Future<void> getCoinDetails({
    required String coinId,
    String? vsCurrency,
    String? days,
  }) async {
    emit(CoinDetailsState.loading());

    try {
      final coinDetailsResult = await coinDetailsRepo.getCoinDetails(coinId);

      final chartResult = await coinDetailsRepo.getChartCoin(
        CoinsChartRequest(
          id: coinId,
          vsCurrency: vsCurrency ?? 'usd',
          days: days ?? '7',
        ),
      );

      coinDetailsResult.when(
        success: (coinDetails) {
          chartResult.when(
            success: (chart) {
              emit(
                CoinDetailsState.loaded(
                  coinDetails: coinDetails,
                  chartPrices: chart,
                ),
              );
            },
            failure: (chartError) {
              log('Chart Error: ${chartError.message}');
              emit(CoinDetailsState.error(message: chartError.message));
            },
          );
        },
        failure: (coinError) {
          log('Coin Error: ${coinError.message}');
          emit(CoinDetailsState.error(message: coinError.message));
        },
      );
    } catch (e) {
      log('Error: $e');
      emit(CoinDetailsState.error(message: e.toString()));
    }
  }
}

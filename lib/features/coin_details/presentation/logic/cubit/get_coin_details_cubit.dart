import 'package:fintech/core/service/api/error/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/coin_details_model.dart';
import '../../../data/repos/get_coin_details_repo.dart';

part 'get_coin_details_state.dart';
part 'get_coin_details_cubit.freezed.dart';

class GetCoinDetailsCubit extends Cubit<GetCoinDetailsState> {
  GetCoinDetailsCubit(this.coinDetailsRepo)
    : super(GetCoinDetailsState.loading());

  final GetCoinDetailsRepo coinDetailsRepo;

  Future<void> getCoinDetails({required String coinId}) async {
    emit(GetCoinDetailsState.loading());
    final result = await coinDetailsRepo.getCoinDetails(coinId);
    result.when(
      success: (coinDetails) {
        emit(GetCoinDetailsState.loaded(coinDetails: coinDetails));
      },
      failure: (error) {
        emit(GetCoinDetailsState.error(message: error.message));
      },
    );
  }
}

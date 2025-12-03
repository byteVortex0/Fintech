import 'package:fintech/core/service/api/error/api_result.dart';
import 'package:fintech/features/market/data/repo/get_all_coins_markets_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/market_coin_request.dart';
import '../../../data/models/market_coin_response.dart';

part 'get_all_coins_markets_state.dart';
part 'get_all_coins_markets_cubit.freezed.dart';

class GetAllCoinsMarketsCubit extends Cubit<GetAllCoinsMarketsState> {
  GetAllCoinsMarketsCubit(this.getAllCoinsMarketsRepo)
    : super(GetAllCoinsMarketsState.loading());

  final GetAllCoinsMarketsRepo getAllCoinsMarketsRepo;

  Future<void> getAllCoinsMarkets({
    MarketCoinRequest? marketCoinRequest,
  }) async {
    emit(GetAllCoinsMarketsState.loading());

    final request =
        marketCoinRequest ??
        MarketCoinRequest(
          vsCurrency: 'usd',
          order: 'market_cap_desc',
          perPage: 50,
          page: 1,
        );

    final result = await getAllCoinsMarketsRepo.getAllCoinsMarkets(request);

    result.when(
      success: (coinsMarkets) {
        emit(GetAllCoinsMarketsState.loaded(coinsMarkets: coinsMarkets));
      },
      failure: (error) {
        emit(GetAllCoinsMarketsState.error(message: error.message));
      },
    );
  }
}

import 'dart:developer';

import '../../../../../core/service/api/error/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/market_coin_request.dart';

import '../../../data/models/market_coin_response.dart';
import '../../../data/models/search_coin_response.dart';
import '../../../data/repo/market_coins_repo.dart';

part 'market_coins_state.dart';
part 'market_coins_cubit.freezed.dart';

class MarketCoinsCubit extends Cubit<MarketCoinsState> {
  MarketCoinsCubit(this.marketCoinsRepo) : super(MarketCoinsState.loading());

  final MarketCoinsRepo marketCoinsRepo;

  Future<void> getAllCoinsMarkets() async {
    emit(MarketCoinsState.loading());

    final request = MarketCoinRequest(
      vsCurrency: 'usd',
      order: 'market_cap_desc',
      perPage: 50,
      page: 1,
    );

    final result = await marketCoinsRepo.getAllCoinsMarkets(request);

    result.when(
      success: (coinsMarkets) {
        emit(MarketCoinsState.loaded(coinsMarkets: coinsMarkets));
      },
      failure: (error) {
        log(error.message);
        emit(MarketCoinsState.error(message: error.message));
      },
    );
  }

  Future<void> searchCoins(String query) async {
    if (query.isEmpty) {
      emit(const MarketCoinsState.empty());
      return;
    }

    emit(const MarketCoinsState.searching());

    final result = await marketCoinsRepo.searchCoins(query);

    result.when(
      success: (searchResults) {
        if (searchResults.isEmpty) {
          emit(const MarketCoinsState.empty());
        } else {
          emit(MarketCoinsState.searchLoaded(searchResults: searchResults));
        }
      },
      failure: (error) {
        emit(MarketCoinsState.searchError(message: error.message));
      },
    );
  }
}

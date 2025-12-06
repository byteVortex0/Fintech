import 'dart:developer';

import 'package:fintech/core/service/api/error/api_result.dart';
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

  int _currentPage = 1;
  bool hasMore = true;
  bool isLoadingMore = false;
  List<MarketCoinResponse> _coins = [];

  Future<void> getAllCoinsMarkets({bool loadMore = false}) async {
    if (isLoadingMore) return;

    if (loadMore) {
      if (!hasMore) return;
      isLoadingMore = true;
      _currentPage++;
    } else {
      emit(MarketCoinsState.loading());
      _currentPage = 1;
      _coins = [];
      hasMore = true;
    }

    final request = MarketCoinRequest(
      vsCurrency: 'usd',
      order: 'market_cap_desc',
      perPage: 50,
      page: _currentPage,
    );

    final result = await marketCoinsRepo.getAllCoinsMarkets(request);

    result.when(
      success: (coinsMarkets) {
        if (coinsMarkets.length < 50) hasMore = false;
        _coins.addAll(coinsMarkets);
        emit(MarketCoinsState.loaded(coinsMarkets: _coins));
      },
      failure: (error) {
        log(error.message);
        emit(MarketCoinsState.error(message: error.message));
      },
    );

    isLoadingMore = false;
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

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

/// MarketCoinsCubit manages market coins data with friendly error messages
class MarketCoinsCubit extends Cubit<MarketCoinsState> {
  MarketCoinsCubit(this.marketCoinsRepo) : super(MarketCoinsState.loading());

  final MarketCoinsRepo marketCoinsRepo;

  Future<void> getAllCoinsMarkets() async {
    emit(MarketCoinsState.loading());

    try {
      final request = MarketCoinRequest(
        vsCurrency: 'usd',
        order: 'market_cap_desc',
        perPage: 50,
        page: 1,
      );

      final result = await marketCoinsRepo.getAllCoinsMarkets(request);

      result.when(
        success: (coinsMarkets) {
          log(
            '[MarketCoinsCubit] getAllCoinsMarkets SUCCESS: ${coinsMarkets.length} coins loaded',
          );
          emit(MarketCoinsState.loaded(coinsMarkets: coinsMarkets));
        },
        failure: (errorModel) {
          log('[MarketCoinsCubit] getAllCoinsMarkets FAILURE');
          log('[MarketCoinsCubit] errorModel type: ${errorModel.runtimeType}');
          log('[MarketCoinsCubit] userMessage: "${errorModel.userMessage}"');
          log('[MarketCoinsCubit] category: ${errorModel.category}');
          log('[MarketCoinsCubit] statusCode: ${errorModel.statusCode}');
          emit(MarketCoinsState.error(message: errorModel.userMessage));
        },
      );
    } catch (e) {
      log('[MarketCoinsCubit] getAllCoinsMarkets UNEXPECTED ERROR: $e');
      log('[MarketCoinsCubit] Error type: ${e.runtimeType}');
      emit(MarketCoinsState.error(message: 'Failed to load market data'));
    }
  }

  Future<void> searchCoins(String query) async {
    if (query.isEmpty) {
      emit(const MarketCoinsState.empty());
      return;
    }

    emit(const MarketCoinsState.searching());

    try {
      final result = await marketCoinsRepo.searchCoins(query);

      result.when(
        success: (searchResults) {
          log(
            '[MarketCoinsCubit] searchCoins SUCCESS: ${searchResults.length} results found',
          );
          if (searchResults.isEmpty) {
            emit(const MarketCoinsState.empty());
          } else {
            emit(MarketCoinsState.searchLoaded(searchResults: searchResults));
          }
        },
        failure: (errorModel) {
          log('[MarketCoinsCubit] searchCoins FAILURE');
          log('[MarketCoinsCubit] userMessage: "${errorModel.userMessage}"');
          emit(MarketCoinsState.searchError(message: errorModel.userMessage));
        },
      );
    } catch (e) {
      log('[MarketCoinsCubit] searchCoins UNEXPECTED ERROR: $e');
      log('[MarketCoinsCubit] Error type: ${e.runtimeType}');
      emit(
        MarketCoinsState.searchError(
          message: 'Search failed. Please try again.',
        ),
      );
    }
  }

  /// Refresh market coins without showing loading indicator
  /// Used for pull-to-refresh gesture
  Future<void> refreshMarketCoins() async {
    log('[MarketCoinsCubit] refreshMarketCoins called');

    try {
      final request = MarketCoinRequest(
        vsCurrency: 'usd',
        order: 'market_cap_desc',
        perPage: 50,
        page: 1,
      );

      final result = await marketCoinsRepo.getAllCoinsMarkets(request);

      result.when(
        success: (coinsMarkets) {
          log(
            '[MarketCoinsCubit] refreshMarketCoins SUCCESS: ${coinsMarkets.length} coins refreshed',
          );
          emit(MarketCoinsState.loaded(coinsMarkets: coinsMarkets));
        },
        failure: (errorModel) {
          log('[MarketCoinsCubit] refreshMarketCoins FAILURE');
          log('[MarketCoinsCubit] userMessage: "${errorModel.userMessage}"');
          emit(MarketCoinsState.error(message: errorModel.userMessage));
        },
      );
    } catch (e) {
      log('[MarketCoinsCubit] refreshMarketCoins UNEXPECTED ERROR: $e');
      log('[MarketCoinsCubit] Error type: ${e.runtimeType}');
      emit(MarketCoinsState.error(message: 'An unexpected error occurred'));
    }
  }
}

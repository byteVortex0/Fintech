import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/holding_model.dart';
import '../../data/models/portfolio_model.dart';
import '../../data/repository/portfolio_repository.dart';
import 'portfolio_state.dart';

/// Cubit managing portfolio data and state
/// Handles fetching, loading, and error states for portfolio data
class PortfolioCubit extends Cubit<PortfolioState> {
  final PortfolioRepository repository;

  // Mock data: coin holdings (amount of each coin held by user)
  final Map<String, double> coinAmounts = {
    'bitcoin': 0.05,
    'ethereum': 1.5,
    'cardano': 26.3,
  };

  PortfolioCubit(this.repository) : super(const PortfolioState.initial());

  /// Load portfolio data from API
  Future<void> loadPortfolio() async {
    emit(const PortfolioState.loading());

    try {
      final result = await repository.fetchHoldingsPrices(
        coinIds: coinAmounts.keys.toList(),
        coinAmounts: coinAmounts,
      );

      final portfolio = result['portfolio'] as PortfolioModel;
      final holdings = result['holdings'] as List<HoldingModel>;

      emit(PortfolioState.loaded(portfolio: portfolio, holdings: holdings));
    } catch (e) {
      emit(PortfolioState.error('Failed to load portfolio: $e'));
    }
  }

  /// Refresh portfolio data (for pull-to-refresh)
  Future<void> refreshPortfolio() async {
    try {
      final result = await repository.fetchHoldingsPrices(
        coinIds: coinAmounts.keys.toList(),
        coinAmounts: coinAmounts,
      );

      final portfolio = result['portfolio'] as PortfolioModel;
      final holdings = result['holdings'] as List<HoldingModel>;

      emit(PortfolioState.loaded(portfolio: portfolio, holdings: holdings));
    } catch (e) {
      emit(PortfolioState.error('Failed to refresh portfolio: $e'));
    }
  }
}

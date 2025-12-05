import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech/features/portfolio/data/models/holding_model.dart';
import 'package:fintech/features/portfolio/data/models/portfolio_model.dart';
import 'package:fintech/features/portfolio/data/repository/portfolio_repository.dart';

part 'portfolio_state.dart';

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

  PortfolioCubit(this.repository) : super(PortfolioInitial());

  /// Load portfolio data from API
  Future<void> loadPortfolio() async {
    emit(PortfolioLoading());

    try {
      final result = await repository.fetchHoldingsPrices(
        coinIds: coinAmounts.keys.toList(),
        coinAmounts: coinAmounts,
      );

      final portfolio = result['portfolio'] as PortfolioModel;
      final holdings = result['holdings'] as List<HoldingModel>;

      emit(PortfolioLoaded(
        portfolio: portfolio,
        holdings: holdings,
      ));
    } catch (e) {
      emit(PortfolioError('Failed to load portfolio: $e'));
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

      emit(PortfolioLoaded(
        portfolio: portfolio,
        holdings: holdings,
      ));
    } catch (e) {
      emit(PortfolioError('Failed to refresh portfolio: $e'));
    }
  }
}

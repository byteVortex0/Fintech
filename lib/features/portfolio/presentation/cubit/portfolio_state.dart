part of 'portfolio_cubit.dart';

/// Portfolio state base class
abstract class PortfolioState {}

/// Initial state when cubit is created
class PortfolioInitial extends PortfolioState {}

/// Loading state when fetching portfolio data
class PortfolioLoading extends PortfolioState {}

/// Loaded state with portfolio data
class PortfolioLoaded extends PortfolioState {
  final PortfolioModel portfolio;
  final List<HoldingModel> holdings;

  PortfolioLoaded({
    required this.portfolio,
    required this.holdings,
  });
}

/// Error state with error message
class PortfolioError extends PortfolioState {
  final String message;

  PortfolioError(this.message);
}

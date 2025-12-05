import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fintech/features/portfolio/data/models/holding_model.dart';
import 'package:fintech/features/portfolio/data/models/portfolio_model.dart';

part 'portfolio_state.freezed.dart';

/// Freezed-based portfolio state management
/// Provides type-safe state pattern with when/maybeWhen support
@freezed
abstract class PortfolioState with _$PortfolioState {
  /// Initial state when cubit is created
  const factory PortfolioState.initial() = PortfolioInitial;

  /// Loading state when fetching portfolio data
  const factory PortfolioState.loading() = PortfolioLoading;

  /// Loaded state with portfolio data
  const factory PortfolioState.loaded({
    required PortfolioModel portfolio,
    required List<HoldingModel> holdings,
  }) = PortfolioLoaded;

  /// Error state with error message
  const factory PortfolioState.error(String message) = PortfolioError;
}

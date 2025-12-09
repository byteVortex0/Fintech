import '../../../../core/configs/api_config.dart';
import '../../../../core/service/api/api_service.dart';
import '../models/holding_model.dart';
import '../models/portfolio_model.dart';

/// Repository handling portfolio data operations
/// Manages API calls, data transformation, and calculations
class PortfolioRepository {
  final ApiService apiService;

  PortfolioRepository(this.apiService);

  /// Fetch live prices for holdings from CoinGecko API
  /// Maps API response to HoldingModel with calculated values
  Future<Map<String, dynamic>> fetchHoldingsPrices({
    required List<String> coinIds,
    required Map<String, double> coinAmounts,
  }) async {
    try {
      // Format coin IDs for API call
      final idsQuery = coinIds.join(',');

      // Fetch prices from CoinGecko
      final response = await apiService.getHoldingsPrices(
        coinIds: idsQuery,
        currency: 'usd',
        include24h: true,
        apiKey: ApiConfig.coinGeckoApiKey,
      );

      // Calculate total portfolio value and individual holdings
      double totalValue = 0;
      final holdings = <HoldingModel>[];

      response.forEach((coinId, priceData) {
        final usdPrice = (priceData['usd'] as num).toDouble();
        final change24h = (priceData['usd_24h_change'] as num).toDouble();
        final amount = coinAmounts[coinId] ?? 0.0;
        final dollarValue = amount * usdPrice;

        totalValue += dollarValue;

        // Create HoldingModel with API data
        // Note: SVG icon paths and percentage will be set after all holdings calculated
        holdings.add(
          HoldingModel(
            coinName: _getCoinName(coinId),
            symbol: _getCoinSymbol(coinId),
            svgIconPath: _getSvgPath(coinId),
            amount: amount,
            percentage: 0, // Will be calculated after total is known
            change: change24h,
            isPositiveChange: change24h >= 0,
            cryptoAmount: amount.toString(),
            dollarValue: dollarValue.toStringAsFixed(2),
            dollarChange: _formatDollarChange(dollarValue, change24h),
          ),
        );
      });

      // Calculate percentages now that total is known
      final holdingsWithPercentage = holdings
          .map(
            (holding) => holding.copyWith(
              percentage: totalValue > 0
                  ? ((double.parse(holding.dollarValue) / totalValue) * 100)
                        .toInt()
                  : 0,
            ),
          )
          .toList();

      // Create portfolio summary
      final portfolio = _calculatePortfolioSummary(
        totalValue,
        holdingsWithPercentage,
      );

      return {'portfolio': portfolio, 'holdings': holdingsWithPercentage};
    } catch (e) {
      throw Exception('Failed to fetch holdings prices: $e');
    }
  }

  /// Calculate portfolio summary with total value and today's change
  PortfolioModel _calculatePortfolioSummary(
    double totalValue,
    List<HoldingModel> holdings,
  ) {
    // Calculate average 24h change weighted by holdings
    double weightedChange = 0;
    for (final holding in holdings) {
      final holdingValue = double.parse(holding.dollarValue);
      final changePercent = holding.change;
      weightedChange += (holdingValue / totalValue) * changePercent;
    }

    final todayChangeAmount = (totalValue * weightedChange) / 100;

    return PortfolioModel(
      totalValue: totalValue,
      todayChange: todayChangeAmount,
      todayChangePercent: weightedChange,
      isPositiveChange: weightedChange >= 0,
    );
  }

  /// Get coin name from coin ID
  String _getCoinName(String coinId) {
    const names = {
      'bitcoin': 'Bitcoin',
      'ethereum': 'Ethereum',
      'cardano': 'Cardano',
    };
    return names[coinId] ?? coinId;
  }

  /// Get coin symbol from coin ID
  String _getCoinSymbol(String coinId) {
    const symbols = {'bitcoin': 'BTC', 'ethereum': 'ETH', 'cardano': 'ADA'};
    return symbols[coinId] ?? coinId.toUpperCase();
  }

  /// Get SVG icon path from coin ID
  String _getSvgPath(String coinId) {
    const paths = {
      'bitcoin': 'assets/svg/bitcoin_btc.svg',
      'ethereum': 'assets/svg/ethereum_eth.svg',
      'cardano': 'assets/svg/litecoin.svg', // Using litecoin as placeholder
    };
    return paths[coinId] ?? 'assets/svg/bitcoin_btc.svg';
  }

  /// Format dollar change based on 24h percentage change
  String _formatDollarChange(double dollarValue, double percentChange) {
    final changeAmount = (dollarValue * percentChange) / 100;
    return changeAmount.toStringAsFixed(2);
  }
}

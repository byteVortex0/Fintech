sealed class ApiEndpoints {
  ApiEndpoints._();
  static const String baseUrl = "https://api.coingecko.com/api/v3/";
  static const String coinsMarkets = "coins/markets";
  static const String coinDetails = "coins/{id}";
  static const String holdingsPrices = "simple/price";
}

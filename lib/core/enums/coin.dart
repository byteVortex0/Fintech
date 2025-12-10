enum Coin {
  bitcoin('Bitcoin', 'BTC'),
  ethereum('Ethereum', 'ETH'),
  litecoin('Litecoin', 'LTC'),
  solana('Solana', 'SOL'),
  binanceCoin('Binance Coin', 'BNB'),
  ripple('Ripple', 'XRP');

  final String name;
  final String symbol;

  const Coin(this.name, this.symbol);

  /// Get coin by name, returns Bitcoin as default
  static Coin fromName(String name) {
    return Coin.values.firstWhere((coin) => coin.name == name, orElse: () => Coin.bitcoin);
  }

  /// Get coin symbol by name, returns BTC as default
  static String getSymbol(String name) {
    return fromName(name).symbol;
  }
}

import '../models/coin_details_model.dart';
import '../models/coin_details_remote_model.dart';

class CoinDetailsMapper {
  static CoinDetailsModel fromRemote(CoinDetailsRemoteModel remote) {
    final remoteMarketData = remote.marketData;

    return CoinDetailsModel(
      name: remote.name,
      price: remoteMarketData['current_price']?['usd']?.toString() ?? '0',
      pricePerUnit: remoteMarketData['price_change_24h']?.toString() ?? '0',
      changePercent:
          remoteMarketData['price_change_percentage_24h']?.toString() ?? '0',
      isPositive: (remoteMarketData['price_change_percentage_24h'] ?? 0) >= 0,
      svgIconPath: remote.image['large'] ?? '',
      currentPrice:
          remoteMarketData['current_price']?['usd']?.toString() ?? '0',
      marketCap: remoteMarketData['market_cap']?['usd']?.toString() ?? '0',
      volume24h: remoteMarketData['total_volume']?['usd']?.toString() ?? '0',
      availableSupply:
          remoteMarketData['circulating_supply']?.toString() ?? '0',
      maxSupply: remoteMarketData['max_supply']?.toString() ?? '0',
      description: remote.description['en'] ?? '',
    );
  }
}

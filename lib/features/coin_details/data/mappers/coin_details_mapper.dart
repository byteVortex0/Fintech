import '../models/coin_details_model.dart';
import '../models/coin_details_remote_model.dart';

class CoinDetailsMapper {
  static CoinDetailsModel fromRemote(CoinDetailsRemoteModel remote) {
    final md = remote.marketData;

    return CoinDetailsModel(
      name: remote.name,
      price: md['current_price']?['usd']?.toString() ?? '0',
      pricePerUnit: md['price_change_24h']?.toString() ?? '0',
      changePercent: md['price_change_percentage_24h']?.toString() ?? '0',
      isPositive: (md['price_change_percentage_24h'] ?? 0) >= 0,
      svgIconPath: remote.image['large'] ?? '',
      currentPrice: md['current_price']?['usd']?.toString() ?? '0',
      marketCap: md['market_cap']?['usd']?.toString() ?? '0',
      volume24h: md['total_volume']?['usd']?.toString() ?? '0',
      availableSupply: md['circulating_supply']?.toString() ?? '0',
      maxSupply: md['max_supply']?.toString() ?? '0',
      description: remote.description['en'] ?? '',
    );
  }
}

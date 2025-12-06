import '../models/coin_ui_model.dart';
import '../models/market_coin_response.dart';
import '../models/search_coin_response.dart';

class CoinMapper {
  static CoinUIModel fromSearchCoinResult(SearchCoin result) {
    return CoinUIModel(
      id: result.id,
      name: result.name,
      symbol: result.symbol,
      image: result.thumb,
    );
  }

  static CoinUIModel fromCoin(MarketCoinResponse coin) {
    return CoinUIModel(
      id: coin.id,
      name: coin.name,
      image: coin.image,
      rank: coin.rank,
      price: coin.price,
      changePercent: coin.changePercent,
    );
  }
}

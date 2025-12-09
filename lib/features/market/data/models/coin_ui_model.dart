class CoinUIModel {
  final String id;
  final String name;
  final String? symbol;
  final String image;
  final int? rank;
  final double? price;
  final double? changePercent;

  CoinUIModel({
    required this.id,
    required this.name,
    this.symbol,
    required this.image,
    this.rank,
    this.price,
    this.changePercent,
  });
}

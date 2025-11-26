import 'package:flutter/material.dart';

/// CoinModel represents a cryptocurrency coin data structure
/// Used across both TrendingCoinCard and TopGainerItem widgets
/// Centralizes coin-related data to avoid parameter duplication
class CoinModel {
  final String coinName;
  final String ticker;
  final String price;
  final String change;
  final String? svgIconPath;
  final IconData? icon;
  final Color? iconColor;

  const CoinModel({
    required this.coinName,
    required this.ticker,
    required this.price,
    required this.change,
    this.svgIconPath,
    this.icon,
    this.iconColor,
  });
}

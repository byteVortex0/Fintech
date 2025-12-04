import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coin_model.freezed.dart';

/// CoinModel represents a cryptocurrency coin data structure
/// Used across both TrendingCoinCard and TopGainerItem widgets
/// Centralizes coin-related data to avoid parameter duplication
/// Freezed provides immutability, copyWith(), equality, and future-proof JSON serialization
@freezed
abstract class CoinModel with _$CoinModel {
  const factory CoinModel({
    required String coinName,
    required String ticker,
    required String price,
    required String change,
    String? svgIconPath,
    IconData? icon,
    Color? iconColor,
  }) = _CoinModel;
}

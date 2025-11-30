import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';

/// Transaction model for recent buy/sell activities
@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String type,
    required String coinName,
    required String timeAgo,
    required String svgIconPath,
    required String cryptoAmount,
    required String dollarValue,
  }) = _TransactionModel;
}

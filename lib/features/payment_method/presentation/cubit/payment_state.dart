import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_state.freezed.dart';

/// Payment processing states using Freezed
@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState.initial() = _Initial;

  const factory PaymentState.loading() = _Loading;

  /// Payment successful with transaction ID
  const factory PaymentState.success(String transactionId) = _Success;

  /// Payment failed with error message
  const factory PaymentState.error(String message) = _Error;

  /// Payment cancelled by user
  const factory PaymentState.cancelled() = _Cancelled;
}

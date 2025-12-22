import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../core/service/payment/payment_service.dart';
import 'payment_state.dart';

/// Payment Cubit - Manages payment processing state
/// Handles Stripe payment sheet and confirmation
class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentState.initial());

  /// Process payment with given amount
  /// Amount should be in cents (e.g., $10.00 = 1000)
  /// Email is used by backend to send receipt
  /// Context is required to show the payment dialog
  Future<void> processPayment({
    required BuildContext context,
    required double amount,
    required String currency,
    required String email,
  }) async {
    try {
      emit(const PaymentState.loading());

      if (kDebugMode) {
        debugPrint(
          '[PaymentCubit] Processing payment for \$${amount / 100} $currency to $email',
        );
      }

      // Process payment with mock payment sheet dialog
      final result = await PaymentService.processPayment(
        context: context,
        amount: amount,
        currency: currency,
        email: email,
      );

      if (result.success) {
        if (kDebugMode) {
          debugPrint(
            '[PaymentCubit] Payment successful: ${result.transactionId}',
          );
        }
        emit(PaymentState.success(result.transactionId ?? ''));
      } else {
        // Check if cancelled by user
        if (result.errorMessage?.contains('cancelled') ?? false) {
          if (kDebugMode) {
            debugPrint('[PaymentCubit] Payment cancelled by user');
          }
          emit(const PaymentState.cancelled());
        } else {
          if (kDebugMode) {
            debugPrint('[PaymentCubit] Payment failed: ${result.errorMessage}');
          }
          emit(PaymentState.error(result.errorMessage ?? 'Payment failed'));
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[PaymentCubit] Payment processing error: $e');
      }
      emit(PaymentState.error('Payment processing failed'));
    }
  }

  /// Reset to initial state
  void reset() {
    emit(const PaymentState.initial());
  }
}

import 'package:flutter/material.dart';
import '../../../features/payment_method/presentation/widgets/mock_payment_sheet_dialog.dart';
import 'payment_api_service.dart';

/// Payment Service - Manages payment processing
/// For DEMO: Uses mock payment sheet dialog
/// In production: Would integrate with Stripe's payment sheet
class PaymentService {
  /// Process payment using mock payment sheet dialog
  ///
  /// Flow:
  /// 1. Call backend to create mock PaymentIntent
  /// 2. Show mock payment sheet dialog to user
  /// 3. User enters card details: 4242 4242 4242 4242
  /// 4. Dialog processes payment and shows success
  /// 5. Return result to caller
  ///
  /// Parameters:
  ///   - context: BuildContext for showing dialog
  ///   - amount: Payment amount in cents (e.g., $10.00 = 1000)
  ///   - currency: Currency code (e.g., 'USD')
  ///   - email: Customer email for receipt
  static Future<PaymentResult> processPayment({
    required BuildContext context,
    required double amount,
    required String currency,
    required String email,
  }) async {
    try {
      debugPrint(
        '[PaymentService] Starting payment flow for \$${amount / 100} $currency',
      );

      // Step 1: Call backend to create payment intent (mock)
      final clientSecret = await PaymentApiService.createPaymentIntent(
        amount: amount,
        currency: currency,
        email: email,
      );

      // Step 2: Show mock payment sheet dialog
      bool paymentSucceeded = false;

      if (!context.mounted) {
        return PaymentResult.error('Context not available');
      }

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return MockPaymentSheetDialog(
            amount: amount / 100,
            currency: currency,
            onSuccess: () {
              paymentSucceeded = true;
              debugPrint(
                '[PaymentService] Payment successful for \$${amount / 100}',
              );
            },
            onError: (error) {
              paymentSucceeded = false;
              debugPrint('[PaymentService] Payment error: $error');
            },
          );
        },
      );

      // Step 3: Return result based on dialog outcome
      if (paymentSucceeded) {
        return PaymentResult.success(
          transactionId: clientSecret,
          amount: amount,
          currency: currency,
        );
      } else {
        return PaymentResult.error('Payment was cancelled');
      }
    } catch (e) {
      debugPrint('[PaymentService] Payment processing ERROR: $e');
      return PaymentResult.error('Payment processing failed: $e');
    }
  }
}

/// Payment result model
class PaymentResult {
  final bool success;
  final String? transactionId;
  final double? amount;
  final String? currency;
  final String? errorMessage;

  PaymentResult({
    required this.success,
    this.transactionId,
    this.amount,
    this.currency,
    this.errorMessage,
  });

  factory PaymentResult.success({
    required String transactionId,
    required double amount,
    required String currency,
  }) {
    return PaymentResult(
      success: true,
      transactionId: transactionId,
      amount: amount,
      currency: currency,
    );
  }

  factory PaymentResult.error(String message) {
    return PaymentResult(success: false, errorMessage: message);
  }
}

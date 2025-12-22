import 'package:flutter/foundation.dart';
import 'dart:math';

/// Payment API Service
/// For DEMO/GRADUATE PROJECT: Uses mock backend simulation
///
/// In production, this would call your backend Cloud Function:
/// - Backend securely handles Stripe secret key
/// - Returns only clientSecret to app
///
/// For this demo, we simulate that flow locally.
class PaymentApiService {
  /// Simulate creating a payment intent via backend
  ///
  /// In real app, this would call Firebase Cloud Function:
  /// POST https://us-central1-yourproject.cloudfunctions.net/createPaymentIntent
  ///
  /// Parameters:
  ///   - amount: Payment amount in cents (e.g., $10.00 = 1000)
  ///   - currency: Currency code (e.g., 'USD')
  ///   - email: Customer email for receipt
  ///
  /// Returns: clientSecret for Stripe payment sheet
  static Future<String> createPaymentIntent({
    required double amount,
    required String currency,
    required String email,
  }) async {
    try {
      debugPrint(
        '[PaymentApiService] Simulating backend PaymentIntent creation',
      );
      debugPrint('[PaymentApiService] Amount: \$${amount / 100} $currency');
      debugPrint('[PaymentApiService] Email: $email');

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Generate mock clientSecret in valid Stripe test format
      // In real app, this comes from Stripe API on backend
      final idPart = _generateRandomString(20);
      final secretPart = _generateRandomString(32);
      final mockClientSecret = 'pi_${idPart}_secret_$secretPart';

      debugPrint(
        '[PaymentApiService] PaymentIntent created (mock): $mockClientSecret',
      );

      return mockClientSecret;
    } catch (e) {
      debugPrint('[PaymentApiService] Error: $e');
      throw Exception('Failed to create payment intent: $e');
    }
  }

  /// Generate random alphanumeric string for mock clientSecret
  static String _generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(
      length,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }
}

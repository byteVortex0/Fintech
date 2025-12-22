/// Payment method types supported by the app
/// This enum defines all available payment options
enum PaymentMethodType { creditCard, googlePay, mobileBanking }

extension PaymentMethodTypeExtension on PaymentMethodType {
  /// Get display name for payment method
  String get displayName {
    switch (this) {
      case PaymentMethodType.creditCard:
        return 'Credit Card';
      case PaymentMethodType.googlePay:
        return 'Google Pay';
      case PaymentMethodType.mobileBanking:
        return 'Mobile Banking';
    }
  }
}

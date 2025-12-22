import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVariables {
  EnvVariables._();

  static final EnvVariables instance = EnvVariables._();

  String _publishableKey = '';
  String _stripeSecretKey = '';

  Future<void> init() async {
    await dotenv.load(fileName: '.env');

    _publishableKey = dotenv.get('PUBLISHABLE_KEY');
    _stripeSecretKey = dotenv.get('STRIPE_SECRET_KEY');
  }

  String get publishableKey => _publishableKey;
  String get stripeSecretKey => _stripeSecretKey;
}

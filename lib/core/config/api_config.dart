import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment-based API configuration using flutter_dotenv
/// Secure way to manage API keys and sensitive configuration
/// See .env.example for required environment variables
class ApiConfig {
  /// CoinGecko API Key loaded from .env file with fallback
  /// Safely handles cases where dotenv may not be initialized
  static String get coinGeckoApiKey {
    try {
      return dotenv.env['COINGECKO_API_KEY'] ?? 'CG-8fMdgfQi2WWFUK57RvpJzDg3';
    } catch (e) {
      // dotenv not initialized, use fallback API key
      return 'CG-8fMdgfQi2WWFUK57RvpJzDg3';
    }
  }
}

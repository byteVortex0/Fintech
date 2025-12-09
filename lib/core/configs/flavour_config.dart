/// Flavour configuration for managing dev and production environments
/// Provides centralized configuration based on build flavour
class FlavourConfig {
  /// Current flavour (dev or prod)
  static final String flavour = const String.fromEnvironment(
    'FLAVOUR',
    defaultValue: 'prod',
  );

  /// Is development flavour
  static bool get isDev => flavour == 'dev';

  /// Is production flavour
  static bool get isProd => flavour == 'prod';

  /// App name based on flavour
  static String get appName => isDev ? 'FinTech Dev' : 'FinTech';

  /// Bundle ID based on flavour
  static String get bundleId => isDev ? 'com.fintech.dev' : 'com.fintech';

  /// Firebase project ID based on flavour
  static String get firebaseProjectId =>
      isDev ? 'fintech-dev-project' : 'fintech-prod-project';

  /// API base URL based on flavour
  static String get apiBaseUrl =>
      isDev ? 'https://api-dev.example.com/v1' : 'https://api.example.com/v1';

  /// Enable debug logs based on flavour
  static bool get enableDebugLogs => isDev;

  /// Enable Dio logger based on flavour
  static bool get enableDioLogger => isDev;

  /// Get display name for current flavour
  static String getDisplayName() {
    switch (flavour) {
      case 'dev':
        return 'Development';
      case 'prod':
        return 'Production';
      default:
        return 'Unknown';
    }
  }

  /// Get environment description
  static String getEnvironmentDescription() =>
      'Running in ${getDisplayName()} mode ($appName)';
}

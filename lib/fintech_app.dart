import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routing/go_router_config.dart';
import 'core/theme/theme_cubit.dart';
import 'core/utils/themes/light_theme.dart';
import 'core/utils/themes/dark_theme.dart';
import 'core/di/injection.dart';
import 'core/security/security_gate.dart';

class FinTechApp extends StatefulWidget {
  const FinTechApp({super.key});

  @override
  State<FinTechApp> createState() => _FinTechAppState();
}

class _FinTechAppState extends State<FinTechApp> {
  static const MethodChannel _channel = MethodChannel('security_channel');
  bool _secureEnabled = false;

  @override
  void initState() {
    super.initState();

    // ✅ Enable secure screen ONCE globally (iOS protects screenshots)
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await _channel.invokeMethod('enableSecureScreen');
        _secureEnabled = true;
        debugPrint('[FinTechApp] ✅ Global secure screen ENABLED');
      } catch (e) {
        debugPrint('[FinTechApp] ❌ Failed to enable secure screen: $e');
      }
    });
  }

  @override
  void dispose() {
    // ✅ Cleanup
    if (_secureEnabled) {
      _channel.invokeMethod('disableSecureScreen');
      debugPrint('[FinTechApp] 🔓 Global secure screen DISABLED');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return BlocProvider(
      create: (context) => sl<ThemeCubit>()..loadSavedTheme(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: BlocBuilder<ThemeCubit, bool>(
          builder: (context, isDarkMode) {
            return MaterialApp.router(
              title: 'FinTech App',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
              routerConfig: goRouter,

              // ✅ Single place for lock/auth logic
              builder: (context, child) {
                return SecurityGate(child: child ?? const SizedBox.shrink());
              },
            );
          },
        ),
      ),
    );
  }
}

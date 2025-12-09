import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routing/go_router_config.dart' show createGoRouter;
import 'core/theme/theme_cubit.dart';
import 'core/utils/themes/light_theme.dart';
import 'core/utils/themes/dark_theme.dart';
import 'core/di/injection.dart';

class FinTechApp extends StatelessWidget {
  const FinTechApp({super.key});

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
              routerConfig: createGoRouter(),
            );
          },
        ),
      ),
    );
  }
}

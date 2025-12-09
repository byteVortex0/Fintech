import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/routing/app_routes.dart';
import '../cubit/auto_login_cubit.dart';
import '../cubit/auto_login_state.dart';

/// Splash screen that checks auto-login eligibility on app startup
/// Navigates to appropriate screen based on auto-login status
class AutoLoginSplashPage extends StatelessWidget {
  const AutoLoginSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AutoLoginCubit>()..checkAutoLogin(),
      child: BlocListener<AutoLoginCubit, AutoLoginState>(
        listener: (context, state) {
          state.maybeWhen(
            biometricRequired: (type) {
              // Navigate to biometric scanning without email/password
              if (type == null) {
                context.go(AppRoutes.login);
              } else if (type == BiometricType.face) {
                context.go(AppRoutes.faceIdScanning);
              } else {
                context.go(AppRoutes.touchIdScanning);
              }
            },
            alreadyLoggedIn: () {
              // User is logged in but no biometric enrollment, go to home
              context.go(AppRoutes.home);
            },
            loginRequired: () {
              // User needs to log in
              context.go(AppRoutes.login);
            },
            error: (message) {
              // On error, go to login page
              context.go(AppRoutes.login);
            },
            orElse: () {},
          );
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text(
                  'Loading...',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

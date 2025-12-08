import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fintech/core/di/injection.dart';
import 'package:fintech/features/login/presentation/cubit/auto_login_cubit.dart';
import 'package:fintech/features/login/presentation/cubit/auto_login_state.dart';

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
            biometricRequired: () {
              // Navigate to biometric scanning without email/password
              context.go('/face_id_scanning');
            },
            alreadyLoggedIn: () {
              // User is logged in but no biometric enrollment, go to home
              context.go('/home');
            },
            loginRequired: () {
              // User needs to log in
              context.go('/login');
            },
            error: (message) {
              // On error, go to login page
              context.go('/login');
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

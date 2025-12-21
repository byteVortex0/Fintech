import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/navigation/navigation_service.dart';
import '../../../../core/routing/app_routes.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import 'touch_id_scanning_page.dart';
import 'face_id_scanning_page.dart';
import '../../data/services/biometric_enrollment_service.dart';
import '../../../../core/utils/user_preferences.dart' show UserPreferences;
import '../widgets/curved_background.dart';
import '../widgets/login_form.dart';
import '../widgets/social_login_section.dart';
import '../widgets/biometric_enrollment_dialog.dart';

/// Main login screen - Authentication entry point for existing users
/// Integrates BLoC for Firebase authentication
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _lastLoginEmail = '';
  String _lastLoginPassword = '';

  void _navigateToFaceId(BuildContext context) async {
    if (kDebugMode) {
      debugPrint('[LoginPage] _navigateToFaceId START');
    }
    // Capture context references before async operations
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    // Try to load stored biometric credentials first
    var email = await UserPreferences.getBiometricEmail() ?? '';
    var password = await UserPreferences.getBiometricPassword() ?? '';

    if (kDebugMode) {
      debugPrint(
        '[LoginPage] _navigateToFaceId - Loaded credentials - email: $email, password: ${password.isNotEmpty}',
      );
    }

    // If no stored credentials, try form fields
    if (email.isEmpty) {
      final formState = _formKey.currentState as dynamic;
      email = formState?.currentEmail ?? '';
      password = formState?.currentPassword ?? '';
      if (kDebugMode) {
        debugPrint(
          '[LoginPage] _navigateToFaceId - Using form credentials - email: $email, password: ${password.isNotEmpty}',
        );
      }
    }

    if (email.isEmpty) {
      if (kDebugMode) {
        debugPrint('[LoginPage] _navigateToFaceId - NO CREDENTIALS FOUND - showing error');
      }
      if (mounted) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text(
              '📱 No stored credentials found.\n\nSteps to enable:\n1. Login with email & password\n2. Tap "Enable" (not Skip)\n3. Logout\n4. Try Face ID again',
            ),
            duration: Duration(seconds: 5),
          ),
        );
      }
      return;
    }

    if (kDebugMode) {
      debugPrint('[LoginPage] _navigateToFaceId - Navigating to FaceIdScanningPage');
    }
    if (mounted) {
      navigator.push(
        MaterialPageRoute(
          builder: (context) => FaceIdScanningPage(email: email, password: password),
        ),
      );
    }
  }

  void _navigateToFingerprint(BuildContext context) async {
    if (kDebugMode) {
      debugPrint('[LoginPage] _navigateToFingerprint START');
    }
    // Capture context references before async operations
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    // Try to load stored biometric credentials first
    var email = await UserPreferences.getBiometricEmail() ?? '';
    var password = await UserPreferences.getBiometricPassword() ?? '';

    if (kDebugMode) {
      debugPrint(
        '[LoginPage] _navigateToFingerprint - Loaded credentials - email: $email, password: ${password.isNotEmpty}',
      );
    }

    // If no stored credentials, try form fields
    if (email.isEmpty) {
      final formState = _formKey.currentState as dynamic;
      email = formState?.currentEmail ?? '';
      password = formState?.currentPassword ?? '';
      if (kDebugMode) {
        debugPrint(
          '[LoginPage] _navigateToFingerprint - Using form credentials - email: $email, password: ${password.isNotEmpty}',
        );
      }
    }

    if (email.isEmpty) {
      if (kDebugMode) {
        debugPrint('[LoginPage] _navigateToFingerprint - NO CREDENTIALS FOUND - showing error');
      }
      if (mounted) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text(
              '📱 No stored credentials found.\n\nSteps to enable:\n1. Login with email & password\n2. Tap "Enable" (not Skip)\n3. Logout\n4. Try Face ID again',
            ),
          ),
        );
      }
      return;
    }

    if (kDebugMode) {
      debugPrint('[LoginPage] _navigateToFingerprint - Navigating to TouchIdScanningPage');
    }
    if (mounted) {
      navigator.push(
        MaterialPageRoute(
          builder: (context) => TouchIdScanningPage(email: email, password: password),
        ),
      );
    }
  }

  void _handleForgotPassword(BuildContext context) {
    // TODO: Navigate to forgot password page
  }

  void _navigateToRegister(BuildContext context) =>
      NavigationService.navigateTo(context, AppRoutes.register);

  void _showBiometricEnrollmentDialog(BuildContext context, String email, String password) {
    if (kDebugMode) {
      debugPrint(
        '[LoginPage] _showBiometricEnrollmentDialog called - email: $email, password: ${password.isNotEmpty}',
      );
    }
    final navigatorContext = context;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => BiometricEnrollmentDialog(
        onEnroll: () async {
          if (kDebugMode) {
            debugPrint(
              '[LoginPage] BiometricEnrollmentDialog onEnroll called - email: $email, password: ${password.isNotEmpty}',
            );
          }
          if (!mounted) return;
          Navigator.pop(dialogContext);
          final enrollmentService = BiometricEnrollmentService();
          await enrollmentService.enrollBiometric(email: email, password: password);
          if (mounted) {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(
              navigatorContext,
            ).showSnackBar(const SnackBar(content: Text('Biometric login enabled successfully')));
            NavigationService.navigateToAndRemoveUntil(
              // ignore: use_build_context_synchronously
              navigatorContext,
              AppRoutes.home,
            );
          }
        },
        onSkip: () {
          if (kDebugMode) {
            debugPrint('[LoginPage] BiometricEnrollmentDialog onSkip called');
          }
          Navigator.pop(dialogContext);
          if (mounted) {
            NavigationService.navigateToAndRemoveUntil(
              // ignore: use_build_context_synchronously
              navigatorContext,
              AppRoutes.home,
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (_) {
              if (kDebugMode) {
                debugPrint(
                  '[LoginPage] authenticated state - using stored credentials - email: $_lastLoginEmail, password: ${_lastLoginPassword.isNotEmpty}',
                );
              }
              // Show biometric enrollment dialog after successful login
              _showBiometricEnrollmentDialog(context, _lastLoginEmail, _lastLoginPassword);
            },
            error: (message) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
            },
            orElse: () {},
          );
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(
            children: [
              const CurvedBackground(),
              SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            SizedBox(height: 80.h),
                            _buildHeader(),
                            SizedBox(height: 48.h),
                            LoginForm(
                              key: _formKey,
                              onLoginPressed: (email, password) {
                                // Store credentials for biometric enrollment
                                _lastLoginEmail = email;
                                _lastLoginPassword = password;
                                if (kDebugMode) {
                                  debugPrint(
                                    '[LoginPage] onLoginPressed - storing credentials - email: $email, password: ${password.isNotEmpty}',
                                  );
                                }
                                context.read<LoginCubit>().login(email: email, password: password);
                              },
                              onForgotPasswordPressed: () => _handleForgotPassword(context),
                            ),
                            if (state.maybeWhen(loading: () => true, orElse: () => false))
                              Padding(
                                padding: EdgeInsets.only(top: 16.h),
                                child: const CircularProgressIndicator(),
                              ),
                            SocialLoginSection(
                              onFingerprintPressed: () => _navigateToFingerprint(context),
                              onFaceIdPressed: () => _navigateToFaceId(context),
                            ),
                            SizedBox(height: 32.h),
                            _buildSignUpRow(context),
                            SizedBox(height: 24.h),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Builder(
      builder: (context) => Column(
        children: [
          Text(
            'Login To Your Account',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Welcome back you've\nbeen missed!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(fontSize: 14.sp, color: Theme.of(context).textTheme.bodyMedium?.color),
        ),
        GestureDetector(
          onTap: () => _navigateToRegister(context),
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

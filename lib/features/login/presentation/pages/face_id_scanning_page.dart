import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech/core/di/injection.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import 'package:fintech/core/routes/app_routes.dart';
import 'package:fintech/core/utils/image_manager.dart';
import 'package:fintech/core/utils/user_preferences.dart';
import 'package:fintech/features/login/presentation/cubit/biometric_cubit.dart';
import 'package:fintech/features/login/presentation/cubit/biometric_state.dart';

/// Wrapper for FaceID scanning page - provides BiometricCubit
/// Receives email and password as route extras from LoginPage
class FaceIdScanningPage extends StatelessWidget {
  final String email;
  final String password;

  const FaceIdScanningPage({super.key, this.email = '', this.password = ''});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BiometricCubit>(),
      child: _FaceIdScanningContent(email: email, password: password),
    );
  }
}

/// Internal content widget for FaceID scanning
class _FaceIdScanningContent extends StatefulWidget {
  final String email;
  final String password;

  const _FaceIdScanningContent({required this.email, required this.password});

  @override
  State<_FaceIdScanningContent> createState() => _FaceIdScanningContentState();
}

class _FaceIdScanningContentState extends State<_FaceIdScanningContent> {
  late String _email;
  late String _password;
  bool _isAuthenticationSuccessful = false;

  @override
  void initState() {
    super.initState();
    _email = widget.email;
    _password = widget.password;
    // Auto-start biometric authentication when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startBiometricAuthentication();
    });
  }

  void _startBiometricAuthentication() async {
    // For auto-login, load stored email if not provided
    if (_email.isEmpty) {
      final storedEmail = await UserPreferences.getBiometricEmail();
      if (storedEmail != null) {
        setState(() => _email = storedEmail);
      }
    }
    // Note: Auto-login with biometric only (password will be handled by Firebase session)
    if (mounted) {
      context.read<BiometricCubit>().authenticateWithBiometrics(
        email: _email,
        password: _password,
        localizedReason: 'Place your face on the sensor',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BiometricCubit, BiometricState>(
      listener: (context, state) {
        if (kDebugMode) {
          debugPrint(
            '[FaceIdScanningPage] BlocListener triggered - state: $state',
          );
        }
        state.maybeWhen(
          authenticated: (uid) {
            if (kDebugMode) {
              debugPrint(
                '[FaceIdScanningPage] authenticated state received - uid: $uid',
              );
              debugPrint('[FaceIdScanningPage] Navigating to home...');
            }
            // Mark authentication as successful to disable back button
            _isAuthenticationSuccessful = true;
            // Navigate to home on successful authentication
            NavigationService.navigateToAndRemoveUntil(context, AppRoutes.home);
          },
          error: (message) {
            if (kDebugMode) {
              debugPrint(
                '[FaceIdScanningPage] error state received - message: $message',
              );
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Authentication failed: $message')),
            );
          },
          notSupported: () {
            if (kDebugMode) {
              debugPrint('[FaceIdScanningPage] notSupported state received');
            }
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Face ID not supported on this device'),
              ),
            );
          },
          orElse: () {
            if (kDebugMode) {
              debugPrint(
                '[FaceIdScanningPage] Other state received (likely loading or initial)',
              );
            }
          },
        );
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackgroundImage(),
            _buildContent(context),
            _buildBackButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return SizedBox.expand(
      child: Image.asset(
        ImageManager.faceIdBg,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            BlocBuilder<BiometricCubit, BiometricState>(
              builder: (context, state) {
                return _buildFaceIdCard(context, state);
              },
            ),
            const Spacer(),
            _buildBottomText(),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }

  Widget _buildFaceIdCard(BuildContext context, BiometricState state) {
    return GestureDetector(
      onTap: () {
        // Allow retry on tap if error occurred
        state.maybeWhen(
          error: (_) => _startBiometricAuthentication(),
          orElse: () {},
        );
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              ImageManager.faceIdWithText,
              width: 155.w,
              height: 158.w,
            ),
            SizedBox(height: 8.h),
            if (state.maybeWhen(loading: () => true, orElse: () => false))
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Text(
        'Please wait until your scanning is\ncomplete',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 48.h,
      left: 16.w,
      child: SafeArea(
        child: GestureDetector(
          // Disable back button after successful authentication to prevent navigation crashes
          onTap: _isAuthenticationSuccessful
              ? null
              : () => NavigationService.goBack(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: _isAuthenticationSuccessful ? Colors.white30 : Colors.white,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}

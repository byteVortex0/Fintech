import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech/core/di/injection.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import 'package:fintech/core/routes/app_routes.dart';
import 'package:fintech/core/utils/image_manager.dart';
import 'package:fintech/features/login/presentation/cubit/biometric_cubit.dart';
import 'package:fintech/features/login/presentation/cubit/biometric_state.dart';
import 'package:fintech/features/login/presentation/widgets/curved_background.dart';

/// Wrapper for TouchID scanning page - provides BiometricCubit
/// Receives email and password as route extras from LoginPage
class TouchIdScanningPage extends StatelessWidget {
  final String email;
  final String password;

  const TouchIdScanningPage({
    super.key,
    this.email = '',
    this.password = '',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BiometricCubit>(),
      child: _TouchIdScanningContent(email: email, password: password),
    );
  }
}

/// Internal content widget for TouchID scanning
class _TouchIdScanningContent extends StatefulWidget {
  final String email;
  final String password;

  const _TouchIdScanningContent({
    required this.email,
    required this.password,
  });

  @override
  State<_TouchIdScanningContent> createState() => _TouchIdScanningContentState();
}

class _TouchIdScanningContentState extends State<_TouchIdScanningContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  double shakeOffset = 0;
  bool _isAuthenticationSuccessful = false;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Auto-start biometric authentication when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startBiometricAuthentication();
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _runShake() async {
    final offsets = List.generate(6, (i) => (i.isEven ? -10.0 : 10.0)) + [0.0];
    for (final offset in offsets) {
      setState(() => shakeOffset = offset);
      await Future.delayed(const Duration(milliseconds: 40));
    }
  }

  void _startBiometricAuthentication() {
    context.read<BiometricCubit>().authenticateWithBiometrics(
      email: widget.email,
      password: widget.password,
      localizedReason: 'Place your finger on the sensor',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BiometricCubit, BiometricState>(
      listener: (context, state) {
        state.maybeWhen(
          authenticated: (uid) {
            // Mark authentication as successful to disable back button
            _isAuthenticationSuccessful = true;
            // Navigate to home on successful authentication
            NavigationService.navigateToAndRemoveUntil(context, AppRoutes.home);
          },
          error: (message) async {
            // Show error animation
            await _runShake();
          },
          notSupported: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Biometric not supported on this device')),
            );
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  children: [
                    _buildBackButton(context),
                    SizedBox(height: 60.h),
                    _buildTitle(),
                    const Spacer(),
                    BlocBuilder<BiometricCubit, BiometricState>(
                      builder: (context, state) {
                        return _buildFingerprintIcon(state);
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<BiometricCubit, BiometricState>(
                      builder: (context, state) {
                        return _buildErrorOrLoadingWidget(state);
                      },
                    ),
                    const Spacer(),
                    _buildSubtitle(),
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        // Disable back button after successful authentication to prevent navigation crashes
        onTap: _isAuthenticationSuccessful ? null : () => NavigationService.goBack(context),
        child: Icon(
          Icons.arrow_back_ios,
          color: _isAuthenticationSuccessful
              ? Theme.of(context).iconTheme.color?.withValues(alpha: 0.3)
              : Theme.of(context).iconTheme.color,
          size: 24.sp,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Builder(
      builder: (context) => Text(
        'Touch ID sensor to verify yourself',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 26.sp,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).textTheme.bodyLarge?.color,
          height: 1.3,
        ),
      ),
    );
  }

  Widget _buildFingerprintIcon(BiometricState state) {
    return GestureDetector(
      onTap: () {
        // Allow retry on tap
        state.maybeWhen(
          error: (_) => _startBiometricAuthentication(),
          orElse: () {},
        );
      },
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(shakeOffset, 0),
            child: Transform.scale(
              scale: _pulseAnimation.value,
              child: Container(
                padding: EdgeInsets.all(30.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 30,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Image.asset(
                  ImageManager.finger,
                  width: 100.w,
                  height: 100.h,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ),
          );
        },
        child: Image.asset(
          ImageManager.finger,
          width: 160.w,
          height: 160.w,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }

  Widget _buildErrorOrLoadingWidget(BiometricState state) {
    return state.maybeWhen(
      loading: () => const CircularProgressIndicator(),
      error: (message) => Column(
        children: [
          Text(
            message,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: _startBiometricAuthentication,
            child: const Text('Retry'),
          ),
        ],
      ),
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _buildSubtitle() {
    return Builder(
      builder: (context) => Text(
        'Please verify your identity using touch\nID and it will proceed automatically.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyMedium?.color,
          height: 1.5,
        ),
      ),
    );
  }
}

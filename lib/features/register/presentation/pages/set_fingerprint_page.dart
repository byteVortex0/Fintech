import 'package:fintech/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import '../../../login/presentation/widgets/curved_background.dart';

class SetFingerprintPage extends StatefulWidget {
  const SetFingerprintPage({super.key});

  @override
  State<SetFingerprintPage> createState() => _SetFingerprintPageState();
}

class _SetFingerprintPageState extends State<SetFingerprintPage>
    with SingleTickerProviderStateMixin {
  final LocalAuthentication auth = LocalAuthentication();
  String errorMessage = '';

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  double shakeOffset = 0;

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
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _runShake() async {
    for (int i = 0; i < 6; i++) {
      setState(() => shakeOffset = (i.isEven ? -10 : 10));
      await Future.delayed(const Duration(milliseconds: 40));
    }
    setState(() => shakeOffset = 0);
  }

  Future<void> _authenticateFingerprint(BuildContext context) async {
    String localError = '';
    bool navigate = false;

    try {
      final bool canCheck = await auth.canCheckBiometrics;
      final bool supported = await auth.isDeviceSupported();

      if (!canCheck || !supported) {
        localError = 'Biometric authentication not available.';
      } else {
        final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Place your finger on the sensor',
        );

        if (didAuthenticate && mounted) {
          navigate = true;
        } else {
          await _runShake();
          localError = 'Authentication failed. Try again.';
        }
      }
    } catch (e) {
      localError = 'Error: ${e.toString()}';
    }

    if (mounted) {
      if (navigate) {
        Navigator.of(context).push(
          AppRoutes.onGenerateRoute(
            RouteSettings(name: AppRoutes.setFingerprintVerified),
          )!,
        );
      } else {
        setState(() => errorMessage = localError);
      }
    }
  }

  void _handleSkip(BuildContext context) =>
      Navigator.of(context).pushAndRemoveUntil(
        AppRoutes.onGenerateRoute(RouteSettings(name: AppRoutes.login))!,
        (route) => false,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          const CurvedBackground(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 80.h),
                    _buildHeader(context),
                    SizedBox(height: 80.h),
                    _buildFingerprintSection(context),
                    if (errorMessage.isNotEmpty) ...[
                      SizedBox(height: 20.h),
                      Text(
                        errorMessage,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    SizedBox(height: 80.h),
                    _buildSkipButton(context),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'Set Your Finger Print',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Add a fingerprint to make your account\nmore secure.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyMedium?.color,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildFingerprintSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _authenticateFingerprint(context),
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
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.fingerprint,
                      size: 120.sp,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ),
              );
            },
          onTap: () => _handleFingerprintSet(context),
          child: Icon(
            Icons.fingerprint,
            size: 180.sp,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        SizedBox(height: 48.h),
        SizedBox(
          width: double.infinity,
          child: Text(
            'Place your finger in fingerprint\nsensor until the icon completely',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkipButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 180.w,
        height: 52.h,
        child: OutlinedButton(
          onPressed: () => _handleSkip(context),
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26.r),
            ),
          ),
          child: Text(
            'Skip',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}

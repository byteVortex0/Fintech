import 'package:fintech/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import 'package:fintech/core/utils/image_manager.dart';
import 'package:fintech/features/login/presentation/widgets/curved_background.dart';

class TouchIdScanningPage extends StatefulWidget {
  const TouchIdScanningPage({super.key});

  @override
  State<TouchIdScanningPage> createState() => _TouchIdScanningPageState();
}

class _TouchIdScanningPageState extends State<TouchIdScanningPage>
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
    final offsets = List.generate(6, (i) => (i.isEven ? -10.0 : 10.0)) + [0.0];
    for (final offset in offsets) {
      setState(() => shakeOffset = offset);
      await Future.delayed(const Duration(milliseconds: 40));
    }
  }

  Future<void> _authenticateUser() async {
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
            RouteSettings(name: AppRoutes.touchIdVerified),
          )!,
        );
      } else {
        setState(() => errorMessage = localError);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FC),
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
                  _buildFingerprintIcon(),
                  const SizedBox(height: 20),
                  _buildErrorMessage(),
                  const Spacer(),
                  _buildSubtitle(),
                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => NavigationService.goBack(context),
        child: Icon(
          Icons.arrow_back_ios,
          color: const Color(0xFF1A2B4A),
          size: 24.sp,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Touch ID sensor to verify yourself',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF1A2B4A),
        height: 1.3,
      ),
    );
  }

  Widget _buildFingerprintIcon() {
    return GestureDetector(
      onTap: _authenticateUser,
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
      ),
    );
  }

  Widget _buildErrorMessage() {
    if (errorMessage.isEmpty) return const SizedBox.shrink();
    return Text(
      errorMessage,
      style: TextStyle(
        fontSize: 14.sp,
        color: Colors.red,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Please verify your identity using touch ID and it will proceed automatically.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF374151),
        height: 1.5,
      ),
    );
  }
}

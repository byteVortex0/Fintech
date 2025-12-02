import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/utils/image_manager.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import 'package:local_auth/local_auth.dart';

class FaceIdScanningPage extends StatefulWidget {
  const FaceIdScanningPage({super.key});

  @override
  State<FaceIdScanningPage> createState() => _FaceIdScanningPageState();
}

class _FaceIdScanningPageState extends State<FaceIdScanningPage> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> authenticate() async {
    try {
      bool isAvailable = await auth.canCheckBiometrics;
      bool isDeviceSupported = await auth.isDeviceSupported();

      if (!isAvailable || !isDeviceSupported) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Face ID not available on this device")),
        );
        return;
      }

      bool didAuthenticate = await auth.authenticate(
        localizedReason: "Scan your face to continue",
        biometricOnly: true,
      );

      if (didAuthenticate) {
        NavigationService.navigateTo(context, '/face_id_verified');
      }
    } catch (e) {
      log("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    // يبدأ قراءة الوجه أول ما الصفحة تفتح
    Future.delayed(const Duration(milliseconds: 200), authenticate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundImage(),
          _buildContent(context),
          _buildBackButton(context),
        ],
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
            _buildFaceIdCard(context),
            const Spacer(),
            _buildBottomText(),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }

  Widget _buildFaceIdCard(BuildContext context) {
    return GestureDetector(
      onTap: authenticate,
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
          onTap: () => NavigationService.goBack(context),
          child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24.sp),
        ),
      ),
    );
  }
}

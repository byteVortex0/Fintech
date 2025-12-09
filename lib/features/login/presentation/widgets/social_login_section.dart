import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/image_manager.dart';

/// SocialLoginSection - Biometric authentication methods orchestrator
///
/// Displays visual divider and interactive biometric login options:
/// - Touch ID / Fingerprint authentication
/// - Face ID authentication
/// Each method is presented as a tappable icon that triggers navigation
/// to the respective biometric capture flow
class SocialLoginSection extends StatelessWidget {
  final VoidCallback onFingerprintPressed;
  final VoidCallback onFaceIdPressed;

  const SocialLoginSection({
    super.key,
    required this.onFingerprintPressed,
    required this.onFaceIdPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24.h),

        /// Visual separator between credential login and biometric options
        _buildDividerRow(),
        SizedBox(height: 24.h),

        /// Interactive fingerprint and face ID authentication buttons
        _buildIconsRow(),
      ],
    );
  }

  /// Builds divider line with "Or login with" text
  /// Creates visual hierarchy separating form submission from alternative auth methods
  Widget _buildDividerRow() {
    return Builder(
      builder: (context) {
        final dividerColor = Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF3E3E3E)
            : const Color(0xFFD1D5DB);

        return Row(
          children: [
            /// Left divider line
            Expanded(child: Divider(color: dividerColor, thickness: 1)),

            /// Center text label
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Or login with',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            /// Right divider line
            Expanded(child: Divider(color: dividerColor, thickness: 1)),
          ],
        );
      },
    );
  }

  /// Builds row with biometric authentication icons
  /// Icons are tappable and route to their respective biometric capture flows
  /// Spacing of 60.w between icons provides comfortable visual separation
  Widget _buildIconsRow() {
    return Builder(
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Fingerprint/Touch ID authentication option
          /// Tapping initiates fingerprint scanning flow
          GestureDetector(
            onTap: onFingerprintPressed,
            child: Image.asset(
              ImageManager.finger,
              width: 56.w,
              height: 56.w,
              color: Theme.of(context).iconTheme.color,
            ),
          ),

          /// Spacing between biometric options
          SizedBox(width: 60.w),

          /// Face ID authentication option
          /// Tapping initiates face ID scanning flow
          GestureDetector(
            onTap: onFaceIdPressed,
            child: Image.asset(
              ImageManager.faceId,
              width: 56.w,
              height: 56.w,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }
}

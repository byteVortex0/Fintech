import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/fonts/font_weight_helper.dart';

/// OnboardingGetStarted - Final slide call-to-action widget
///
/// Rendered only on the last onboarding slide (slide 4).
/// Provides two authentication path options: Login or Register.
/// Button styling hierarchy emphasizes Login as primary action (filled)
/// with Register as secondary option (outlined).
class OnboardingGetStarted extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onRegister;

  const OnboardingGetStarted({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Primary CTA: Login button with filled dark navy background
        /// ElevatedButton signals primary action with strong contrast
        /// Full width (double.infinity) for prominent visibility
        /// 56.h height provides comfortable touch target
        ElevatedButton(
          onPressed: onLogin,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            minimumSize: Size(double.infinity, 56.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.semiBold,
              color: Colors.white,
            ),
          ),
        ),

        /// Vertical spacing between primary and secondary actions
        SizedBox(height: 12.h),

        /// Secondary CTA: Register button with outline style
        /// OutlinedButton distinguishes secondary action without overwhelming primary button
        /// 2px dark navy border maintains visual hierarchy
        OutlinedButton(
          onPressed: onRegister,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 2,
            ),
            minimumSize: Size(double.infinity, 56.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(
            'Register',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.semiBold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Dialog to prompt user for biometric enrollment after successful login
class BiometricEnrollmentDialog extends StatelessWidget {
  final VoidCallback onEnroll;
  final VoidCallback onSkip;

  const BiometricEnrollmentDialog({
    super.key,
    required this.onEnroll,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Text(
        'Enable Biometric Login',
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
      ),
      content: Text(
        'Use Face ID or fingerprint for faster and more secure login?',
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onSkip,
          child: Text(
            'Skip',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onEnroll,
          child: Text(
            'Enable',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

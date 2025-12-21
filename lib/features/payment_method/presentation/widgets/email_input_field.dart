import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Email input field for payment receipt
/// Simple text field for user to enter their email
class EmailInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool visible;

  const EmailInputField({super.key, required this.controller, this.visible = false});

  @override
  Widget build(BuildContext context) {
    // Only show if email receipt is enabled
    if (!visible) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Enter your email',
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        style: TextStyle(fontSize: 14.sp, color: Theme.of(context).textTheme.bodyLarge?.color),
      ),
    );
  }
}

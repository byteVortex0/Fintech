import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/utils/color_manager.dart';

/// Reusable settings item with icon, text, and chevron
class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool showBorder;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: showBorder
            ? const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: LightColorManager.borderColor,
                    width: 1,
                  ),
                ),
              )
            : null,
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: const BoxDecoration(
                color: Color(0xFF1E3A5F),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E3A5F),
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF9E9E9E),
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}

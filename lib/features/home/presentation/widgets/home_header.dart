import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Home screen header widget
/// Displays user greeting and notification bell icon
class HomeHeader extends StatelessWidget {
  final VoidCallback onNotificationPressed;

  const HomeHeader({super.key, required this.onNotificationPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: const Color(0xFF1A2B4A),
                child: Text(
                  'A',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, Abdulrahman',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A2B4A),
                    ),
                  ),
                  Text('👋', style: TextStyle(fontSize: 14.sp)),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: onNotificationPressed,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none,
                color: const Color(0xFF1A2B4A),
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

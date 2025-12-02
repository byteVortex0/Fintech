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
                backgroundColor: Theme.of(context).colorScheme.secondary,
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
                      color: Theme.of(context).textTheme.bodyLarge?.color,
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
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF2A2A2A)
                    : const Color(0xFFE5E7EB),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none,
                color: Theme.of(context).iconTheme.color,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

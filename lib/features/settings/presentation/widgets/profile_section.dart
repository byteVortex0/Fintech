import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Profile section with circular image and user name
class ProfileSection extends StatelessWidget {
  final String name;
  final String imagePath;

  const ProfileSection({
    super.key,
    required this.name,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 70.r,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Text(
            'A',
            style: TextStyle(
              fontSize: 40.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          name,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ],
    );
  }
}

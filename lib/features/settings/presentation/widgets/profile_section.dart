import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Profile section with circular image and user name
class ProfileSection extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String imagePath;

  const ProfileSection({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final firstInitial = firstName.isNotEmpty ? firstName[0].toUpperCase() : 'U';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 70.r,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Text(
            firstInitial,
            style: TextStyle(
              fontSize: 40.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              firstName,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            if (lastName.isNotEmpty) ...[
              SizedBox(width: 8.w),
              Text(
                lastName,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

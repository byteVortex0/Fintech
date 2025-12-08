import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/features/settings/data/models/user_profile_model.dart';

/// Profile section with circular avatar and user name display
class ProfileSection extends StatelessWidget {
  final UserProfileModel userProfile;

  const ProfileSection({
    super.key,
    required this.userProfile,
  });

  @override
  Widget build(BuildContext context) {
    final firstInitial = userProfile.firstName.isNotEmpty
        ? userProfile.firstName[0].toUpperCase()
        : 'U';

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
              userProfile.firstName,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            if (userProfile.lastName.isNotEmpty) ...[
              SizedBox(width: 8.w),
              Text(
                userProfile.lastName,
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

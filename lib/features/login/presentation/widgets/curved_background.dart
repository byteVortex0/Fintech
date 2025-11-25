import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// CurvedBackground - Decorative circular background design element
///
/// Creates a light blue circular shape positioned in the top-right corner
/// of LoginPage (offset by -80.h, -80.w for partial visibility).
/// Provides visual hierarchy and modern design aesthetic.
/// Light blue (#D6E4F0) color complements the login form styling.
class CurvedBackground extends StatelessWidget {
  const CurvedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -80.h,
      right: -80.w,
      /// Large circle (300x300) sized to create visual impact
      /// Positioned outside screen bounds for elegant partial visibility
      child: Container(
        width: 300.w,
        height: 300.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFD6E4F0),
        ),
      ),
    );
  }
}

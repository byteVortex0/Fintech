import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurvedBackground extends StatelessWidget {
  const CurvedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -80.h,
      right: -80.w,
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

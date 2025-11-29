import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/utils/image_manager.dart';

class GradientCardDisplay extends StatelessWidget {
  const GradientCardDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Image.asset(
        ImageManager.card,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinHeaderSection extends StatelessWidget {
  final String name;
  final String svgIconPath;

  const CoinHeaderSection({
    super.key,
    required this.name,
    required this.svgIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(svgIconPath, width: 40.w, height: 40.w),
        SizedBox(width: 12.w),
        Text(
          name,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ],
    );
  }
}

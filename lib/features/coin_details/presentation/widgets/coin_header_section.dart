import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoinHeaderSection extends StatelessWidget {
  final String name;
  final String? svgIconPath;

  const CoinHeaderSection({
    super.key,
    required this.name,
    this.svgIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (svgIconPath != null)
          SvgPicture.asset(
            svgIconPath!,
            width: 40.w,
            height: 40.w,
          )
        else
          Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              color: Color(0xFFE5E7EB),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.currency_bitcoin,
              size: 24.sp,
              color: const Color(0xFF6B7280),
            ),
          ),
        SizedBox(width: 12.w),
        Text(
          name,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A2B4A),
          ),
        ),
      ],
    );
  }
}

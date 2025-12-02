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
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF2A2A2A)
                  : const Color(0xFFE5E7EB),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.currency_bitcoin,
              size: 24.sp,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
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

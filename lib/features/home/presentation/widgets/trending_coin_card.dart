import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;

/// Trending coin card widget
/// Displays individual coin with icon, name, ticker, and price
class TrendingCoinCard extends StatelessWidget {
  final String coinName;
  final String ticker;
  final String price;
  final String change;
  final String? svgIconPath;
  final IconData? icon;
  final Color? iconColor;

  const TrendingCoinCard({
    super.key,
    required this.coinName,
    required this.ticker,
    required this.price,
    required this.change,
    this.svgIconPath,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (svgIconPath != null)
            svg.SvgPicture.asset(
              svgIconPath!,
              width: 32.w,
              height: 32.h,
            )
          else if (icon != null)
            Icon(
              icon,
              color: iconColor,
              size: 32.sp,
            ),
          SizedBox(height: 8.h),
          Text(
            coinName,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A2B4A),
            ),
          ),
          Text(
            ticker,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            price,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A2B4A),
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: Colors.green,
                size: 12.sp,
              ),
              SizedBox(width: 2.w),
              Text(
                change,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

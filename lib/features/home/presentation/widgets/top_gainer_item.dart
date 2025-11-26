import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;

/// Top gainer item widget
/// Displays individual gainer row with icon, name, price, and change
class TopGainerItem extends StatelessWidget {
  final String coinName;
  final String ticker;
  final String price;
  final String change;
  final String? svgIconPath;
  final IconData? icon;
  final Color? iconColor;

  const TopGainerItem({
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          if (svgIconPath != null)
            svg.SvgPicture.asset(
              svgIconPath!,
              width: 28.w,
              height: 28.h,
            )
          else if (icon != null)
            Icon(
              icon,
              color: iconColor,
              size: 28.sp,
            ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A2B4A),
                ),
              ),
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
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

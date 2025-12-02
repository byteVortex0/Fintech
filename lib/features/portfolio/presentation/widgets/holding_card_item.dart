import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fintech/features/portfolio/data/models/holding_model.dart';

/// Individual cryptocurrency holding card showing value, percentage, and change
class HoldingCardItem extends StatelessWidget {
  final HoldingModel holding;

  const HoldingCardItem({
    super.key,
    required this.holding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            holding.svgIconPath,
            width: 48.w,
            height: 48.h,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  holding.coinName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  holding.symbol,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  holding.cryptoAmount,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  holding.dollarValue,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${holding.percentage}%',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                holding.dollarChange,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: holding.isPositiveChange
                      ? const Color(0xFF00C853)
                      : const Color(0xFFFF5252),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                '${holding.isPositiveChange ? '+' : ''}${holding.change.toStringAsFixed(2)}%',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: holding.isPositiveChange
                      ? const Color(0xFF00C853)
                      : const Color(0xFFFF5252),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import '../../data/models/coin_model.dart';

/// Trending coin card widget
/// Displays individual coin with icon, name, ticker, and price
class TrendingCoinCard extends StatelessWidget {
  final CoinModel coin;

  const TrendingCoinCard({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (coin.svgIconPath != null)
            svg.SvgPicture.asset(coin.svgIconPath!, width: 32.w, height: 32.h)
          else if (coin.icon != null)
            Icon(coin.icon, color: coin.iconColor, size: 32.sp),
          SizedBox(height: 8.h),
          Text(
            coin.coinName,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          Text(
            coin.ticker,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            coin.price,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(Icons.trending_up, color: Colors.green, size: 12.sp),
              SizedBox(width: 2.w),
              Text(
                coin.change,
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

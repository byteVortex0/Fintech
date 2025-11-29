import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import '../../data/models/coin_model.dart';

/// Top gainer item widget
/// Displays individual gainer row with icon, name, price, and change
class TopGainerItem extends StatelessWidget {
  final CoinModel coin;

  const TopGainerItem({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          if (coin.svgIconPath != null)
            svg.SvgPicture.asset(coin.svgIconPath!, width: 28.w, height: 28.h)
          else if (coin.icon != null)
            Icon(coin.icon, color: coin.iconColor, size: 28.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coin.coinName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A2B4A),
                  ),
                ),
                Text(
                  coin.ticker,
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
                coin.price,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A2B4A),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.trending_up, color: Colors.green, size: 12.sp),
                  SizedBox(width: 2.w),
                  Text(
                    coin.change,
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

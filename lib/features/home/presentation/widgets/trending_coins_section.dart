import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/utils/svg_icon_manager.dart';
import 'trending_coin_card.dart';

/// Trending coins section widget
/// Displays "Trending Now" header with horizontal scrollable coins
///
/// Architecture: Uses callback pattern so parent (HomeScreen) controls navigation via NavigationService
class TrendingCoinsSection extends StatelessWidget {
  final VoidCallback onViewAllPressed;

  const TrendingCoinsSection({super.key, required this.onViewAllPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Now',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A2B4A),
                ),
              ),
              GestureDetector(
                onTap: onViewAllPressed,
                child: Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1A5FFF),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 180.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              TrendingCoinCard(
                coinName: 'Bitcoin',
                ticker: 'BTC',
                price: '1,132,151',
                change: '2.35%',
                svgIconPath: SvgIconManager.bitcoinIcon,
              ),
              SizedBox(width: 12.w),
              TrendingCoinCard(
                coinName: 'Ethereum',
                ticker: 'ETH',
                price: '1,132,151',
                change: '2.35%',
                svgIconPath: SvgIconManager.ethereumIcon,
              ),
              SizedBox(width: 12.w),
              TrendingCoinCard(
                coinName: 'Bitcoin',
                ticker: 'BTC',
                price: '1,132,151',
                change: '2.35%',
                svgIconPath: SvgIconManager.bitcoinIcon,
              ),
              SizedBox(width: 12.w),
              TrendingCoinCard(
                coinName: 'Ethereum',
                ticker: 'ETH',
                price: '1,132,151',
                change: '2.35%',
                svgIconPath: SvgIconManager.ethereumIcon,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

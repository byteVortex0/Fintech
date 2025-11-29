import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:fintech/core/navigation/navigation_service.dart';
import 'package:fintech/core/routes/app_routes.dart';
import '../../data/models/market_coin_model.dart';

/// CoinListItem widget for market coin list
/// Displays coin with icon, name, rank, price, and change percentage
class CoinListItem extends StatelessWidget {
  final MarketCoinModel coin;

  const CoinListItem({
    super.key,
    required this.coin,
  });

  Color _getChangeColor() {
    final changeValue = double.tryParse(coin.changePercent) ?? 0;
    return changeValue >= 0 ? const Color(0xFF10B981) : const Color(0xFFEF4444);
  }

  void _navigateToCoinDetails(BuildContext context) {
    final iconParam = coin.svgIconPath != null ? '&icon=${coin.svgIconPath}' : '';
    NavigationService.navigateTo(
      context,
      '${AppRoutes.coinDetails}?name=${coin.name}$iconParam',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: GestureDetector(
        onTap: () => _navigateToCoinDetails(context),
        child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4.r,
              spreadRadius: 0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Coin Icon
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: coin.svgIconPath != null
                    ? svg.SvgPicture.asset(
                        coin.svgIconPath!,
                        width: 28.w,
                        height: 28.h,
                      )
                    : Icon(
                        Icons.currency_bitcoin,
                        size: 24.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
              ),
            ),
            SizedBox(width: 12.w),
            // Coin Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coin.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A2B4A),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Rank #${coin.rank}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
            // Price and Change
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
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getChangeColor().withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    coin.changePercent.startsWith('+')
                        ? '↗ ${coin.changePercent}'
                        : '↘ ${coin.changePercent}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: _getChangeColor(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }
}

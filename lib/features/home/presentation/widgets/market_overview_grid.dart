import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/features/home/data/models/global_response.dart';

class MarketOverviewGrid extends StatelessWidget {
  final GlobalData globalData;

  const MarketOverviewGrid({super.key, required this.globalData});

  @override
  Widget build(BuildContext context) {
    final marketCapUsd = globalData.totalMarketCap['usd'] ?? 0;
    final volumeUsd = globalData.totalVolume['usd'] ?? 0;
    final btcDominance = globalData.marketCapPercentage['btc'] ?? 0;
    final activeCoins = globalData.activeCryptocurrencies;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Market Overview',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: 12.h),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.2,
            children: [
              _buildStatCard(
                context,
                'Market Cap',
                '\$${_formatNumber(marketCapUsd)}',
                '',
              ),
              _buildStatCard(
                context,
                '24h Volume',
                '\$${_formatNumber(volumeUsd)}',
                '',
              ),
              _buildStatCard(
                context,
                'BTC Dominance',
                '${btcDominance.toStringAsFixed(1)}%',
                '',
              ),
              _buildStatCard(context, 'Active Coins', '$activeCoins', ''),
            ],
          ),
        ],
      ),
    );
  }

  String _formatNumber(double number) {
    if (number >= 1e12) {
      return '${(number / 1e12).toStringAsFixed(1)}T';
    } else if (number >= 1e9) {
      return '${(number / 1e9).toStringAsFixed(1)}B';
    } else if (number >= 1e6) {
      return '${(number / 1e6).toStringAsFixed(1)}M';
    } else {
      return number.toStringAsFixed(0);
    }
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    String change,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: 4.h),
          if (change.isNotEmpty)
            Row(
              children: [
                Icon(Icons.trending_up, color: Colors.green, size: 12.sp),
                SizedBox(width: 2.w),
                Text(
                  change,
                  style: TextStyle(
                    fontSize: 12.sp,
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/features/home/data/models/trending_response.dart';
import '../../data/models/coin_model.dart';
import 'trending_coin_card.dart';

class TrendingCoinsSection extends StatelessWidget {
  final List<TrendingCoin> trendingCoins;
  final VoidCallback onViewAllPressed;

  const TrendingCoinsSection({
    super.key,
    required this.trendingCoins,
    required this.onViewAllPressed,
  });

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
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              GestureDetector(
                onTap: onViewAllPressed,
                child: Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 180.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: trendingCoins.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final coin = trendingCoins[index].item;

              return TrendingCoinCard(
                coin: CoinModel(
                  coinName: coin.name,
                  ticker: coin.symbol.toUpperCase(),
                  price: coin.priceBtc.toStringAsFixed(8),
                  change: '0%',
                  svgIconPath: null,
                  icon: Icons.currency_bitcoin,
                  iconColor: Colors.orange,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

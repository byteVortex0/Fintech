import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/features/market/data/models/market_coin_response.dart';
import '../../data/models/coin_model.dart';
import 'top_gainer_item.dart';


class TopGainersSection extends StatelessWidget {
  final List<MarketCoinResponse> topGainers;

  const TopGainersSection({super.key, required this.topGainers});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Text(
            'Top Gainers',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: topGainers.length > 3 ? 3 : topGainers.length,
          itemBuilder: (context, index) {
            final coin = topGainers[index];
            return TopGainerItem(
              coin: CoinModel(
                coinName: coin.name,
                ticker: coin.id.toUpperCase(),
                price: '\$${coin.price.toStringAsFixed(2)}',
                change: '${coin.changePercent >= 0 ? '+' : ''}${coin.changePercent.toStringAsFixed(2)}%',
                svgIconPath: null,
                icon: Icons.currency_bitcoin,
                iconColor: Colors.orange,
              ),
            );
          },
        ),
      ],
    );
  }
}
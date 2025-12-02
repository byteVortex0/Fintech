import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/utils/svg_icon_manager.dart';
import '../../data/models/coin_model.dart';
import 'top_gainer_item.dart';

/// Top gainers section widget
/// Displays list of top gaining coins
class TopGainersSection extends StatelessWidget {
  const TopGainersSection({super.key});

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
        TopGainerItem(
          coin: CoinModel(
            coinName: 'Ethereum',
            ticker: 'ETH',
            price: '\$20.788',
            change: '+0.25%',
            svgIconPath: SvgIconManager.topGainerEthereumIcon,
          ),
        ),
        TopGainerItem(
          coin: CoinModel(
            coinName: 'Binance Coin',
            ticker: 'BNS',
            price: '\$20.788',
            change: '+1.15%',
            svgIconPath: SvgIconManager.topGainerBinanceIcon,
          ),
        ),
        TopGainerItem(
          coin: CoinModel(
            coinName: 'Litecoin',
            ticker: 'LTC',
            price: '\$20.788',
            change: '+1.15%',
            svgIconPath: SvgIconManager.topGainerLiteCoinIcon,
          ),
        ),
      ],
    );
  }
}

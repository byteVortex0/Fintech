import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/utils/svg_icon_manager.dart';
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
              color: const Color(0xFF1A2B4A),
            ),
          ),
        ),
        TopGainerItem(
          svgIconPath: SvgIconManager.topGainerEthereumIcon,
          coinName: 'Ethereum',
          ticker: 'ETH',
          price: '\$20.788',
          change: '+0.25%',
        ),
        TopGainerItem(
          svgIconPath: SvgIconManager.topGainerBinanceIcon,
          coinName: 'Binance Coin',
          ticker: 'BNS',
          price: '\$20.788',
          change: '+1.15%',
        ),
        TopGainerItem(
          svgIconPath: SvgIconManager.topGainerLiteCoinIcon,
          coinName: 'Litecoin',
          ticker: 'LTC',
          price: '\$20.788',
          change: '+1.15%',
        ),
      ],
    );
  }
}

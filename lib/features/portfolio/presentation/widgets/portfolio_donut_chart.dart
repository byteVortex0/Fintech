import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/holding_model.dart';

/// Portfolio distribution display with simple circular indicators
class PortfolioDonutChart extends StatelessWidget {
  final double totalValue;
  final List<HoldingModel> holdings;

  const PortfolioDonutChart({
    super.key,
    required this.totalValue,
    required this.holdings,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFF9C27B0), // Purple for BTC
      const Color(0xFF00BCD4), // Cyan for ETH
      const Color(0xFFFF7043), // Coral for LTC
    ];

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 120.h,
                width: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 15),
                ),
              ),
              Container(
                height: 120.h,
                width: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    colors: [
                      colors[0],
                      colors[0],
                      colors[1],
                      colors[1],
                      colors[2],
                      colors[2],
                    ],
                    stops: const [0.0, 0.5, 0.5, 0.8, 0.8, 1.0],
                  ),
                ),
              ),
              Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).cardTheme.color,
                ),
                child: Center(
                  child: Text(
                    '\$${totalValue.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 24.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.min,
            children: holdings.asMap().entries.map((entry) {
              final index = entry.key;
              final holding = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  children: [
                    Container(
                      width: 12.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: colors[index % colors.length],
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '\$${holding.amount.toStringAsFixed(2)} ${holding.symbol}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

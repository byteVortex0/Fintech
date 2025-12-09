import 'package:fintech/features/market/data/models/coin_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// CoinListItem widget for market coin list
/// Displays coin with icon, name, rank, price, and change percentage
class CoinListItem extends StatelessWidget {
  final CoinUIModel coinUIModel;
  final double? changePercent;
  final VoidCallback? onTap;

  const CoinListItem({
    super.key,
    required this.coinUIModel,
    this.changePercent,
    this.onTap,
  });

  Color? _getChangeColor() {
    if (changePercent == null) return null;
    return changePercent! >= 0
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);
  }

  @override
  Widget build(BuildContext context) {
    final changeColor = _getChangeColor();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4.r,
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
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Image.network(
                    coinUIModel.image,
                    width: 28.w,
                    height: 28.h,
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
                      coinUIModel.name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    if (coinUIModel.symbol != null)
                      Text(
                        coinUIModel.symbol!.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    if (coinUIModel.rank != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        'Rank #${coinUIModel.rank}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Price and Change (Optional)
              if (coinUIModel.price != null && changePercent != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${coinUIModel.price!.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: changeColor!.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        '${changePercent!.toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: changeColor,
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

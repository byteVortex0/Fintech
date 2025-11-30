import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/features/portfolio/data/models/transaction_model.dart';

/// Individual transaction item showing buy/sell activity with coin and time
class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final isBuy = transaction.type.toLowerCase() == 'buy';

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: isBuy
                  ? const Color(0xFF00C853).withValues(alpha: 0.1)
                  : const Color(0xFFFF5252).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isBuy ? Icons.arrow_upward : Icons.arrow_downward,
              color: isBuy ? const Color(0xFF00C853) : const Color(0xFFFF5252),
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${transaction.type} ${transaction.coinName}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A2B4A),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  transaction.timeAgo,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction.cryptoAmount,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A2B4A),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                transaction.dollarValue,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF00C853),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/image_manager.dart';

class ExchangeFeeCard extends StatelessWidget {
  final String feePercentage;
  final String feeAmount;

  const ExchangeFeeCard({
    super.key,
    required this.feePercentage,
    required this.feeAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Image.asset(ImageManager.money),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Exchange fee',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  feePercentage,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
          Text(
            feeAmount,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}

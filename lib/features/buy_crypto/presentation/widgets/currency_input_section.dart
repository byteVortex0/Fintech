import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyInputSection extends StatelessWidget {
  final String label;
  final String amount;
  final String currency;
  final Function(String) onCurrencyChanged;

  const CurrencyInputSection({
    super.key,
    required this.label,
    required this.amount,
    required this.currency,
    required this.onCurrencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$$amount',
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A2B4A),
              ),
            ),
            _buildCurrencyDropdown(),
          ],
        ),
      ],
    );
  }

  Widget _buildCurrencyDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.attach_money,
            size: 20.sp,
            color: const Color(0xFF1A2B4A),
          ),
          SizedBox(width: 8.w),
          Text(
            currency,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A2B4A),
            ),
          ),
          SizedBox(width: 8.w),
          Icon(
            Icons.keyboard_arrow_down,
            size: 20.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ],
      ),
    );
  }
}

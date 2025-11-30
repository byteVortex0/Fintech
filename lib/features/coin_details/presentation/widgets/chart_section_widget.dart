import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChartSectionWidget extends StatelessWidget {
  final String selectedPeriod;
  final Function(String) onPeriodSelected;

  const ChartSectionWidget({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          // Gradient area chart placeholder
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF1A2B4A).withValues(alpha: 0.3),
                  const Color(0xFF1A2B4A).withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                'Chart Placeholder',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Time period buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimePeriodButton('1h'),
              _buildTimePeriodButton('1d'),
              _buildTimePeriodButton('1w'),
              _buildTimePeriodButton('1m'),
              _buildTimePeriodButton('1y'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimePeriodButton(String period) {
    final isSelected = period == selectedPeriod;
    return GestureDetector(
      onTap: () => onPeriodSelected(period),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A2B4A) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          period,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }
}

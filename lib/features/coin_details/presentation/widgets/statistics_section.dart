import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticsSection extends StatelessWidget {
  final String currentPrice;
  final String marketCap;
  final String volume24h;
  final String availableSupply;
  final String maxSupply;

  const StatisticsSection({
    super.key,
    required this.currentPrice,
    required this.marketCap,
    required this.volume24h,
    required this.availableSupply,
    required this.maxSupply,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statics',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A2B4A),
          ),
        ),
        SizedBox(height: 16.h),
        _buildStatRow('Current Price', currentPrice),
        _buildDivider(),
        _buildStatRow('Market Cap', marketCap),
        _buildDivider(),
        _buildStatRow('Volume 24h', volume24h),
        _buildDivider(),
        _buildStatRow('Available Supply', availableSupply),
        _buildDivider(),
        _buildStatRow('Max Supply', maxSupply),
      ],
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1A2B4A),
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.info,
                size: 16.sp,
                color: const Color(0xFF2563EB),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A2B4A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1.h,
      thickness: 1.h,
      color: const Color(0xFFE5E7EB),
    );
  }
}

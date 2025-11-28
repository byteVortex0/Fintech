import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// MarketSearchBar widget for market screen
/// Provides search functionality with filter icon
class MarketSearchBar extends StatefulWidget {
  final Function(String) onSearchChanged;
  final VoidCallback onFilterPressed;

  const MarketSearchBar({
    super.key,
    required this.onSearchChanged,
    required this.onFilterPressed,
  });

  @override
  State<MarketSearchBar> createState() => _MarketSearchBarState();
}

class _MarketSearchBarState extends State<MarketSearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8.r,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: const Color(0xFF9CA3AF),
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: widget.onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF1A2B4A),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: widget.onFilterPressed,
              child: Icon(
                Icons.tune,
                color: const Color(0xFF1A2B4A),
                size: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

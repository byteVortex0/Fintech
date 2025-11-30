import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Horizontal scrollable time period selector with month chips
class TimePeriodSelector extends StatefulWidget {
  const TimePeriodSelector({super.key});

  @override
  State<TimePeriodSelector> createState() => _TimePeriodSelectorState();
}

class _TimePeriodSelectorState extends State<TimePeriodSelector> {
  int selectedIndex = 4; // Mar is selected by default (index 4)

  final List<String> months = ['Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apl'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: months.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF0063F7) : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF0063F7)
                      : const Color(0xFFE0E0E0),
                ),
              ),
              child: Center(
                child: Text(
                  months[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF757575),
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

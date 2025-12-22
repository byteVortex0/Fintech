import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/image_manager.dart';
import 'gradient_card_display.dart';

/// Credit Card Section
/// Displays available credit card options with visual selection indicator
/// Credit card is the primary payment method for this demo
class CreditCardSection extends StatefulWidget {
  final bool isSelected;

  const CreditCardSection({super.key, this.isSelected = true});

  @override
  State<CreditCardSection> createState() => _CreditCardSectionState();
}

class _CreditCardSectionState extends State<CreditCardSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16.r),
        // Show colored border when selected
        border: widget.isSelected
            ? Border.all(
                color: Theme.of(context).colorScheme.secondary,
                width: 2,
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Credit Card',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              // Show checkmark icon when selected
              if (widget.isSelected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 24.sp,
                ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(ImageManager.visa),
              Image.asset(ImageManager.creditCard),
              Image.asset(ImageManager.applePay),
            ],
          ),
          SizedBox(height: 20.h),
          const GradientCardDisplay(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/utils/image_manager.dart';
import 'package:fintech/features/payment_method/presentation/widgets/gradient_card_display.dart';

class CreditCardSection extends StatefulWidget {
  const CreditCardSection({super.key});

  @override
  State<CreditCardSection> createState() => _CreditCardSectionState();
}

class _CreditCardSectionState extends State<CreditCardSection> {
  int selectedMethodIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16.r),
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
              Icon(
                Icons.keyboard_arrow_up,
                color: Theme.of(context).iconTheme.color,
                size: 28.sp,
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

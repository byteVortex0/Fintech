import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/features/portfolio/data/models/holding_model.dart';
import 'package:fintech/features/portfolio/presentation/widgets/holding_card_item.dart';

/// My Holdings section with title and list of cryptocurrency holdings
class MyHoldingsSection extends StatelessWidget {
  final List<HoldingModel> holdings;

  const MyHoldingsSection({super.key, required this.holdings});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Holdings',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        SizedBox(height: 16.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: holdings.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return HoldingCardItem(holding: holdings[index]);
          },
        ),
      ],
    );
  }
}

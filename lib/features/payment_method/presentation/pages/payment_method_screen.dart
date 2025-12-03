import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/shared/widgets/primary_button.dart';
import 'package:fintech/shared/widgets/app_back_button.dart';
import 'package:fintech/features/payment_method/presentation/widgets/credit_card_section.dart';
import 'package:fintech/features/payment_method/presentation/widgets/payment_option_row.dart';
import 'package:fintech/features/payment_method/presentation/widgets/email_receipt_toggle.dart';

/// Payment Method Screen - Payment selection and confirmation
class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool sendEmailReceipt = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: const AppBackButton(),
        title: Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CreditCardSection(),
                    SizedBox(height: 16.h),
                    const PaymentOptionRow(title: 'Google Pay'),
                    SizedBox(height: 16.h),
                    const PaymentOptionRow(title: 'Mobile Banking'),
                    SizedBox(height: 24.h),
                    EmailReceiptToggle(
                      value: sendEmailReceipt,
                      onChanged: (value) {
                        setState(() {
                          sendEmailReceipt = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: PrimaryButton(
                text: 'Buy',
                backgroundColor: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  // TODO: Implement payment confirmation
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app/widgets/primary_button.dart';
import '../../../../core/app/widgets/app_back_button.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/navigation/navigation_service.dart';
import '../widgets/credit_card_section.dart';
import '../widgets/payment_option_row.dart';
import '../widgets/email_receipt_toggle.dart';
import '../widgets/email_input_field.dart';
import '../cubit/payment_cubit.dart';
import '../cubit/payment_state.dart';
import '../models/payment_method_model.dart';

/// Payment Method Screen - Payment selection and confirmation
/// User can:
/// - Select payment method (Credit Card by default)
/// - Enter email for receipt
/// - Confirm payment
class PaymentMethodScreen extends StatefulWidget {
  final double amountInCents;
  final String currency;

  const PaymentMethodScreen({super.key, this.amountInCents = 0.0, this.currency = 'USD'});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  // Track selected payment method
  late PaymentMethodType selectedMethod = PaymentMethodType.creditCard;

  // Email for receipt
  final emailController = TextEditingController();
  bool sendEmailReceipt = false;

  @override
  void dispose() {
    // Clean up email controller when screen is closed
    emailController.dispose();
    super.dispose();
  }

  /// Validate email format
  /// Returns true if email is valid or receipt not required
  bool _isEmailValid() {
    if (!sendEmailReceipt) return true; // Email not required

    final email = emailController.text.trim();
    if (email.isEmpty) return false;

    // Simple email validation regex
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PaymentCubit>(),
      child: Scaffold(
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
        body: BlocListener<PaymentCubit, PaymentState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (transactionId) {
                // Show success snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Payment successful! ID: ${transactionId.substring(0, 8)}...'),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                  ),
                );
                // Auto-navigate back after 2 seconds
                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted && context.mounted) {
                    NavigationService.goBack(context);
                  }
                });
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              cancelled: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Payment cancelled'),
                    backgroundColor: Colors.orange,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            );
          },
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Amount display
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Amount',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).textTheme.bodyMedium?.color,
                                ),
                              ),
                              Text(
                                '${widget.currency} ${(widget.amountInCents / 100).toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        // Credit card is selected by default
                        CreditCardSection(
                          isSelected: selectedMethod == PaymentMethodType.creditCard,
                        ),
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
                        SizedBox(height: 16.h),
                        // Show email input only if receipt is enabled
                        EmailInputField(controller: emailController, visible: sendEmailReceipt),
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
                  child: BlocBuilder<PaymentCubit, PaymentState>(
                    builder: (context, state) {
                      final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);

                      return PrimaryButton(
                        text: isLoading ? 'Processing...' : 'Pay Now',
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        onPressed: isLoading
                            ? () {}
                            : () {
                                // Validate email if receipt is required
                                if (!_isEmailValid()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Please enter a valid email'),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                  return;
                                }

                                // Get email (empty string if not required)
                                final email = sendEmailReceipt ? emailController.text.trim() : '';

                                // Process payment with selected method and email
                                context.read<PaymentCubit>().processPayment(
                                  context: context,
                                  amount: widget.amountInCents,
                                  currency: widget.currency,
                                  email: email,
                                );
                              },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

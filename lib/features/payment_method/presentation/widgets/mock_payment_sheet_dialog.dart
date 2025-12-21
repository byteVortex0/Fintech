import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Mock Payment Sheet Dialog
/// Simulates Stripe payment sheet for demo/testing
/// Allows entering test card: 4242 4242 4242 4242
class MockPaymentSheetDialog extends StatefulWidget {
  final double amount;
  final String currency;
  final VoidCallback onSuccess;
  final Function(String) onError;

  const MockPaymentSheetDialog({
    Key? key,
    required this.amount,
    required this.currency,
    required this.onSuccess,
    required this.onError,
  }) : super(key: key);

  @override
  State<MockPaymentSheetDialog> createState() => _MockPaymentSheetDialogState();
}

class _MockPaymentSheetDialogState extends State<MockPaymentSheetDialog> {
  late TextEditingController cardController;
  late TextEditingController expiryController;
  late TextEditingController cvcController;
  bool isProcessing = false;
  bool isSuccess = false;

  @override
  void initState() {
    super.initState();
    cardController = TextEditingController();
    expiryController = TextEditingController();
    cvcController = TextEditingController();
  }

  @override
  void dispose() {
    cardController.dispose();
    expiryController.dispose();
    cvcController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    final card = cardController.text.replaceAll(' ', '');
    if (card.isEmpty || card.length < 13) {
      widget.onError('Invalid card number');
      return false;
    }
    if (expiryController.text.isEmpty) {
      widget.onError('Invalid expiry date');
      return false;
    }
    if (cvcController.text.isEmpty || cvcController.text.length < 3) {
      widget.onError('Invalid CVC');
      return false;
    }
    return true;
  }

  void _processPayment() async {
    if (!_validateInputs()) return;

    setState(() => isProcessing = true);

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      isProcessing = false;
      isSuccess = true;
    });

    // Show success message and close
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      widget.onSuccess();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
      child: Padding(
        padding: EdgeInsets.all(20.sp),
        child: isSuccess ? _buildSuccessState() : _buildPaymentForm(),
      ),
    );
  }

  Widget _buildSuccessState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle, color: Colors.green, size: 60.sp),
        SizedBox(height: 16.sp),
        Text(
          'Payment Done!',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.sp),
        Text(
          '${widget.currency} ${widget.amount.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPaymentForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Card Details',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.sp),
        TextField(
          controller: cardController,
          decoration: InputDecoration(
            hintText: '4242 4242 4242 4242',
            labelText: 'Card Number',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 12.sp),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: expiryController,
                decoration: InputDecoration(
                  hintText: 'MM/YY',
                  labelText: 'Expiry',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 12.sp),
            Expanded(
              child: TextField(
                controller: cvcController,
                decoration: InputDecoration(
                  hintText: 'CVC',
                  labelText: 'CVC',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.sp),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isProcessing ? null : _processPayment,
            child: isProcessing
                ? SizedBox(
                    height: 20.sp,
                    width: 20.sp,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                : Text('Pay Now'),
          ),
        ),
      ],
    );
  }
}

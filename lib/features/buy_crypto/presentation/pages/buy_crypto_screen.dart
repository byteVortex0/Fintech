import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/navigation/navigation_service.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/enums/coin.dart';
import '../../../../core/app/widgets/app_back_button.dart';
import '../widgets/currency_input_section.dart';
import '../widgets/exchange_rate_indicator.dart';
import '../widgets/exchange_fee_card.dart';

/// Buy Crypto Screen - Currency exchange interface
class BuyCryptoScreen extends StatefulWidget {
  final String? coinName;

  const BuyCryptoScreen({super.key, this.coinName});

  @override
  State<BuyCryptoScreen> createState() => _BuyCryptoScreenState();
}

class _BuyCryptoScreenState extends State<BuyCryptoScreen> {
  String payCurrency = 'USD';
  String receiveCurrency = 'ETH';
  double payAmount = 1800.00;
  double receiveAmount = 0.9876;

  @override
  void initState() {
    super.initState();
    if (widget.coinName != null) {
      receiveCurrency = Coin.getSymbol(widget.coinName!);
    }
  }

  void _handleContinue() {
    NavigationService.navigateTo(context, AppRoutes.paymentMethod);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 24.h),
                    Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        children: [
                          CurrencyInputSection(
                            label: 'You Pay',
                            amount: payAmount.toStringAsFixed(2),
                            currency: payCurrency,
                            onCurrencyChanged: (value) {
                              setState(() => payCurrency = value);
                            },
                          ),
                          SizedBox(height: 20.h),
                          _buildExchangeArrows(),
                          SizedBox(height: 20.h),
                          CurrencyInputSection(
                            label: 'You Receive',
                            amount: receiveAmount.toStringAsFixed(4),
                            currency: receiveCurrency,
                            onCurrencyChanged: (value) {
                              setState(() => receiveCurrency = value);
                            },
                          ),
                          SizedBox(height: 24.h),
                          ExchangeRateIndicator(
                            fromCurrency: payCurrency,
                            toCurrency: receiveCurrency,
                            rate: '0.00078',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    const ExchangeFeeCard(feePercentage: '0.05%', feeAmount: '\$26'),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
            _buildContinueButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          const AppBackButton(),
          const Spacer(),
          Text(
            'Buy Crypto',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const Spacer(),
          SizedBox(width: 24.sp),
        ],
      ),
    );
  }

  Widget _buildExchangeArrows() {
    return Builder(
      builder: (context) => Row(
        children: [
          Expanded(
            child: Divider(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF3E3E3E)
                  : const Color(0xFFE5E7EB),
              thickness: 1.h,
            ),
          ),
          SizedBox(width: 12.w),
          Icon(Icons.swap_vert, size: 24.sp, color: const Color(0xFFFF6B2C)),
          SizedBox(width: 12.w),
          Expanded(
            child: Divider(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF3E3E3E)
                  : const Color(0xFFE5E7EB),
              thickness: 1.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: _handleContinue,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
          ),
          child: Text(
            'Continue',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

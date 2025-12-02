import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/utils/svg_icon_manager.dart';
import 'package:fintech/features/portfolio/data/models/portfolio_model.dart';
import 'package:fintech/features/portfolio/data/models/holding_model.dart';
import 'package:fintech/features/portfolio/data/models/transaction_model.dart';
import 'package:fintech/features/portfolio/presentation/widgets/total_value_card.dart';
import 'package:fintech/features/portfolio/presentation/widgets/time_period_selector.dart';
import 'package:fintech/features/portfolio/presentation/widgets/portfolio_donut_chart.dart';
import 'package:fintech/features/portfolio/presentation/widgets/my_holdings_section.dart';
import 'package:fintech/features/portfolio/presentation/widgets/recent_transactions_section.dart';

/// Portfolio screen showing total value, holdings distribution, and transactions
class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder data for portfolio overview
    final portfolioData = const PortfolioModel(
      totalValue: 143421.20,
      todayChange: 305.20,
      todayChangePercent: 2.5,
      isPositiveChange: true,
    );

    // Placeholder data for holdings
    final holdingsData = [
      const HoldingModel(
        coinName: 'Bitcoin',
        symbol: 'BTC',
        svgIconPath: SvgIconManager.bitcoinIcon,
        amount: 54382.64,
        percentage: 50,
        change: 6.85,
        isPositiveChange: true,
        cryptoAmount: '0.05 BTC',
        dollarValue: '\$2,262.53',
        dollarChange: '+\$145.20',
      ),
      const HoldingModel(
        coinName: 'Ethereum',
        symbol: 'ETH',
        svgIconPath: SvgIconManager.ethereumIcon,
        amount: 4145.61,
        percentage: 30,
        change: 1.83,
        isPositiveChange: true,
        cryptoAmount: '1.5 ETH',
        dollarValue: '\$3,150.75',
        dollarChange: '+\$56.70',
      ),
      const HoldingModel(
        coinName: 'Litecoin',
        symbol: 'LTC',
        svgIconPath: SvgIconManager.liteCoinIcon,
        amount: 6420.50,
        percentage: 20,
        change: 5.07,
        isPositiveChange: true,
        cryptoAmount: '26.3 LTC',
        dollarValue: '\$2,503.76',
        dollarChange: '+\$120.80',
      ),
    ];

    // Placeholder data for recent transactions
    final transactionsData = [
      const TransactionModel(
        type: 'Buy',
        coinName: 'Bitcoin',
        timeAgo: '2 hours ago',
        svgIconPath: SvgIconManager.bitcoinIcon,
        cryptoAmount: '0.01 BTC',
        dollarValue: '-\$452.50',
      ),
      const TransactionModel(
        type: 'Sell',
        coinName: 'Ethereum',
        timeAgo: '1 day ago',
        svgIconPath: SvgIconManager.ethereumIcon,
        cryptoAmount: '0.5 ETH',
        dollarValue: '+\$1,050.25',
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Portfolio',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TotalValueCard(portfolio: portfolioData),
              SizedBox(height: 24.h),
              const TimePeriodSelector(),
              SizedBox(height: 24.h),
              PortfolioDonutChart(
                totalValue: portfolioData.totalValue,
                holdings: holdingsData,
              ),
              SizedBox(height: 24.h),
              MyHoldingsSection(holdings: holdingsData),
              SizedBox(height: 24.h),
              RecentTransactionsSection(transactions: transactionsData),
            ],
          ),
        ),
      ),
    );
  }
}

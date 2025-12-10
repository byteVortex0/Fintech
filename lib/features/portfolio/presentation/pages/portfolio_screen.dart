import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/utils/svg_icon_manager.dart';
import '../../data/models/transaction_model.dart';
import '../cubit/portfolio_cubit.dart';
import '../cubit/portfolio_state.dart';
import '../widgets/total_value_card.dart';
import '../widgets/time_period_selector.dart';
import '../widgets/portfolio_donut_chart.dart';
import '../widgets/my_holdings_section.dart';
import '../widgets/recent_transactions_section.dart';

/// Portfolio screen showing total value, holdings distribution, and transactions
/// Uses BLoC pattern to manage portfolio data fetching from API
class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PortfolioCubit>()..loadPortfolio(),
      child: const _PortfolioScreenContent(),
    );
  }
}

class _PortfolioScreenContent extends StatelessWidget {
  const _PortfolioScreenContent();

  @override
  Widget build(BuildContext context) {
    // Mock transactions data (static, doesn't come from API yet)
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
        child: BlocBuilder<PortfolioCubit, PortfolioState>(
          builder: (context, state) {
            return state.maybeWhen(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error loading portfolio',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFF5252),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    SizedBox(height: 24.h),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PortfolioCubit>().loadPortfolio();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              loaded: (portfolio, holdings) => RefreshIndicator(
                onRefresh: () =>
                    context.read<PortfolioCubit>().refreshPortfolio(),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TotalValueCard(portfolio: portfolio),
                      SizedBox(height: 24.h),
                      const TimePeriodSelector(),
                      SizedBox(height: 24.h),
                      PortfolioDonutChart(
                        totalValue: portfolio.totalValue,
                        holdings: holdings,
                      ),
                      SizedBox(height: 24.h),
                      MyHoldingsSection(holdings: holdings),
                      SizedBox(height: 24.h),
                      RecentTransactionsSection(transactions: transactionsData),
                    ],
                  ),
                ),
              ),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}

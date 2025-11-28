import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import 'package:fintech/core/utils/color_manager.dart';
import 'widgets/home_header.dart';
import 'widgets/current_balance_card.dart';
import 'widgets/market_overview_grid.dart';
import 'widgets/trending_coins_section.dart';
import 'widgets/top_gainers_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColorManager.screenBackground,
      body: SafeArea(
        child: ListView(
          shrinkWrap: false,
          children: [
            HomeHeader(
              onNotificationPressed: () {
                // TODO: Navigate to notifications screen
              },
            ),
            CurrentBalanceCard(),
            MarketOverviewGrid(),
            TrendingCoinsSection(
              onViewAllPressed: () =>
                  NavigationService.navigateTo(context, '/market'),
            ),
            SizedBox(height: 12.h),
            TopGainersSection(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

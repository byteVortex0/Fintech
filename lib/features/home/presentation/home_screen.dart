import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import 'package:fintech/core/routes/app_routes.dart';
import 'package:fintech/core/utils/color_manager.dart';
import 'package:fintech/shared/widgets/app_bottom_navigation.dart';
import 'widgets/home_header.dart';
import 'widgets/current_balance_card.dart';
import 'widgets/market_overview_grid.dart';
import 'widgets/trending_coins_section.dart';
import 'widgets/top_gainers_section.dart';

/// Home screen - Main dashboard for cryptocurrency portfolio overview
/// Displays balance, market overview, trending coins, and top gainers
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
            /// Navigation flow: User taps "View all" → callback triggered → NavigationService routes to market
            TrendingCoinsSection(
              onViewAllPressed: () {
                /// CRITICAL RULE #15: All navigation uses NavigationService + AppRoutes constants
                NavigationService.navigateTo(AppRoutes.market);
              },
            ),
            SizedBox(height: 12.h),
            TopGainersSection(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(),
    );
  }
}

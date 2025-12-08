import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import 'package:fintech/core/di/injection.dart' show sl;
import 'package:fintech/features/settings/data/repository/settings_repository.dart';
import 'widgets/home_header.dart';
import 'widgets/current_balance_card.dart';
import 'widgets/market_overview_grid.dart';
import 'widgets/trending_coins_section.dart';
import 'widgets/top_gainers_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _firstName = 'User';
  String _lastName = '';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final repository = sl<SettingsRepository>();
      final userProfile = await repository.getUserProfile();
      setState(() {
        _firstName = userProfile.firstName;
        _lastName = userProfile.lastName;
      });
    } catch (e) {
      // Keep default values if fetch fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: ListView(
          shrinkWrap: false,
          children: [
            HomeHeader(
              onNotificationPressed: () {
                // TODO: Navigate to notifications screen
              },
              firstName: _firstName,
              lastName: _lastName,
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

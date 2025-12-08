import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import 'package:fintech/core/di/injection.dart' show sl;
import 'package:fintech/features/home/presentation/cubit/home_cubit.dart';
import 'widgets/home_header.dart';
import 'widgets/current_balance_card.dart';
import 'widgets/market_overview_grid.dart';
import 'widgets/trending_coins_section.dart';
import 'widgets/top_gainers_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..fetchUserProfile(),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    final userProfile = context.watch<HomeCubit>().state;
    final firstName = userProfile?.firstName ?? 'User';
    final lastName = userProfile?.lastName ?? '';

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
              firstName: firstName,
              lastName: lastName,
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

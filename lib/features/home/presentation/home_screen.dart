import 'package:fintech/core/di/injection.dart';
import 'package:fintech/features/home/presentation/logic/cubit/home_screen_cubit.dart';
import 'package:fintech/features/home/presentation/widgets/current_balance_card.dart';
import 'package:fintech/features/home/presentation/widgets/home_header.dart';
import 'package:fintech/features/home/presentation/widgets/market_overview_grid.dart';
import 'package:fintech/features/home/presentation/widgets/top_gainers_section.dart';
import 'package:fintech/features/home/presentation/widgets/trending_coins_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/navigation/navigation_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeScreenCubit>()..getHomeScreen(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
            builder: (context, state) {
              return state.when(
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
                loaded: (data) {
                  return ListView(
                    shrinkWrap: false,
                    children: [
                      HomeHeader(
                        onNotificationPressed: () {
                          // TODO: Navigate to notifications screen
                        },
                      ),
                      CurrentBalanceCard(),
                      MarketOverviewGrid(globalData: data.global.data),
                      TrendingCoinsSection(
                        trendingCoins: data.trending.coins,
                        onViewAllPressed: () =>
                            NavigationService.navigateTo(context, '/market'),
                      ),
                      SizedBox(height: 12.h),
                      TopGainersSection(topGainers: data.topGainers),
                      SizedBox(height: 20.h),
                    ],
                  );
                },
                error: (message) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64.sp,
                          color: Colors.red,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Error: $message',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () {
                            context.read<HomeScreenCubit>().getHomeScreen();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                },
                empty: () {
                  return Center(
                    child: Text(
                      'No data available',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

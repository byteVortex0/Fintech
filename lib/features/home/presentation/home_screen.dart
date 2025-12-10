import '../../../core/di/injection.dart';
import 'logic/cubit/home_cubit.dart';
import 'widgets/current_balance_card.dart';
import 'widgets/home_header.dart';
import 'widgets/market_overview_grid.dart';
import 'widgets/top_gainers_section.dart';
import 'widgets/trending_coins_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/navigation/navigation_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..getHomeScreen(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return state.when(
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
                loaded: (data, userProfile) {
                  return ListView(
                    shrinkWrap: false,
                    children: [
                      HomeHeader(
                        onNotificationPressed: () {
                          // TODO: Navigate to notifications screen
                        },
                        firstName: userProfile.firstName,
                        lastName: '',
                      ),
                      CurrentBalanceCard(),
                      MarketOverviewGrid(globalData: data.global.data),
                      TrendingCoinsSection(
                        trendingCoins: data.trending.coins,
                        onViewAllPressed: () => NavigationService.navigateTo(context, '/market'),
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
                        Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
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
                            context.read<HomeCubit>().getHomeScreen();
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

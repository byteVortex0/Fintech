import 'package:fintech/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import 'package:fintech/core/routes/app_routes.dart';
import 'package:fintech/shared/widgets/app_back_button.dart';
import '../logic/cubit/get_coin_details_cubit.dart';
import '../widgets/coin_header_section.dart';
import '../widgets/price_card_widget.dart';
import '../widgets/chart_section_widget.dart';
import '../widgets/statistics_section.dart';
import '../widgets/about_section.dart';
import '../widgets/action_buttons_section.dart';

/// Coin Details Screen - Displays detailed cryptocurrency information
class CoinDetailsScreen extends StatelessWidget {
  final String id;

  const CoinDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          sl<GetCoinDetailsCubit>()..getCoinDetails(coinId: id),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              BlocBuilder<GetCoinDetailsCubit, GetCoinDetailsState>(
                builder: (context, state) {
                  return state.when(
                    loading: () {
                      return Expanded(
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                    error: (message) {
                      return Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            'Error: $message',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),
                      );
                    },
                    loaded: (coinDetailsData) {
                      return Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16.h),
                              CoinHeaderSection(
                                name: coinDetailsData.name,
                                svgIconPath: coinDetailsData.svgIconPath,
                              ),
                              SizedBox(height: 16.h),
                              PriceCardWidget(
                                price: coinDetailsData.price,
                                pricePerUnit: coinDetailsData.pricePerUnit,
                                changePercent: coinDetailsData.changePercent,
                                isPositive: coinDetailsData.isPositive,
                              ),
                              SizedBox(height: 20.h),
                              ChartSectionWidget(
                                selectedPeriod: '1D',
                                onPeriodSelected: (period) {
                                  // setState(() {
                                  //   selectedTimePeriod = period;
                                  // });
                                },
                              ),
                              SizedBox(height: 24.h),
                              StatisticsSection(
                                currentPrice: coinDetailsData.currentPrice,
                                marketCap: coinDetailsData.marketCap,
                                volume24h: coinDetailsData.volume24h,
                                availableSupply:
                                    coinDetailsData.availableSupply,
                                maxSupply: coinDetailsData.maxSupply,
                              ),
                              SizedBox(height: 24.h),
                              AboutSection(
                                coinName: coinDetailsData.name,
                                description: coinDetailsData.description,
                              ),
                              SizedBox(height: 24.h),
                              ActionButtonsSection(
                                onSellPressed: () {
                                  // TODO: Navigate to sell screen
                                },
                                onBuyPressed: () {
                                  NavigationService.navigateTo(
                                    context,
                                    '${AppRoutes.buyCrypto}?coinName=${coinDetailsData.name}',
                                  );
                                },
                              ),
                              SizedBox(height: 24.h),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
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
            'Coin Details',
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
}

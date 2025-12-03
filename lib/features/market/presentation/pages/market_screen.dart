import 'package:fintech/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../logic/cubit/get_all_coins_markets_cubit.dart';
import '../widgets/market_search_bar.dart';
import '../widgets/category_filter.dart';
import '../widgets/coin_list_item.dart';

/// Market Screen - Displays cryptocurrency market listing
/// Shows coins with filters, search, and detailed pricing information
class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  String searchQuery = '';
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GetAllCoinsMarketsCubit>()..getAllCoinsMarkets(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Crypto Market',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              // Search Bar
              MarketSearchBar(
                onSearchChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                },
                onFilterPressed: () {
                  // TODO: Implement filter functionality
                },
              ),
              SizedBox(height: 16.h),
              // Category Filter
              CategoryFilter(
                onCategorySelected: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              ),
              SizedBox(height: 12.h),
              // Coin List
              BlocBuilder<GetAllCoinsMarketsCubit, GetAllCoinsMarketsState>(
                builder: (context, state) {
                  return state.when(
                    loading: () {
                      return const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                    error: (message) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            'Error: $message',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                    empty: () {
                      return Expanded(
                        child: Center(
                          child: Text(
                            'No coins found',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                    loaded: (coinsMarkets) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: coinsMarkets.length,
                          itemBuilder: (context, index) {
                            return CoinListItem(coin: coinsMarkets[index]);
                          },
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
}

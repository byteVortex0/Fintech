import 'dart:async';

import '../../../../core/di/injection.dart';
import '../../data/mapper/coin_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/navigation/navigation_service.dart';
import '../../../../core/routing/app_routes.dart';
import '../logic/cubit/market_coins_cubit.dart';
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
  String selectedCategory = 'All';

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MarketCoinsCubit>()..getAllCoinsMarkets(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 16.h),
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

                  MarketSearchBar(
                    onSearchChanged: (query) {
                      _debounce?.cancel();

                      _debounce = Timer(const Duration(milliseconds: 500), () {
                        final cubit = context.read<MarketCoinsCubit>();

                        if (query.trim().isEmpty) {
                          cubit.getAllCoinsMarkets();
                        } else {
                          cubit.searchCoins(query);
                        }
                      });
                    },

                    onFilterPressed: () {},
                  ),
                  SizedBox(height: 16.h),

                  CategoryFilter(
                    onCategorySelected: (category) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                  SizedBox(height: 12.h),

                  Expanded(
                    child: RefreshIndicator.adaptive(
                      onRefresh: () async {
                        context.read<MarketCoinsCubit>().getAllCoinsMarkets(
                          forceRefresh: true,
                        );
                      },
                      child: BlocBuilder<MarketCoinsCubit, MarketCoinsState>(
                        builder: (context, state) {
                          return state.when(
                            loading: () =>
                                Center(child: CircularProgressIndicator()),

                            searching: () =>
                                Center(child: CircularProgressIndicator()),

                            error: (message) => Center(
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
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 24.h),
                                  ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<MarketCoinsCubit>()
                                          .getAllCoinsMarkets();
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            ),

                            searchError: (message) => Center(
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
                                    'Search Error: $message',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 24.h),
                                  ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<MarketCoinsCubit>()
                                          .getAllCoinsMarkets();
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            ),

                            empty: () => Center(
                              child: Text(
                                'No results found',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.color,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            loaded: (coinsMarkets, hasMore, isLoadingMore) {
                              return NotificationListener<ScrollNotification>(
                                onNotification: (scroll) {
                                  if (scroll.metrics.pixels >=
                                      scroll.metrics.maxScrollExtent - 200) {
                                    context
                                        .read<MarketCoinsCubit>()
                                        .getAllCoinsMarkets(loadMore: true);
                                  }
                                  return false;
                                },
                                child: ListView.builder(
                                  itemCount:
                                      coinsMarkets.length + (hasMore ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    if (index < coinsMarkets.length) {
                                      final coin = coinsMarkets[index];
                                      return CoinListItem(
                                        coinUIModel: CoinMapper.fromCoin(coin),
                                        changePercent: coin.changePercent,
                                        onTap: () {
                                          NavigationService.navigateTo(
                                            context,
                                            '${AppRoutes.coinDetails}?id=${coin.id}',
                                          );
                                        },
                                      );
                                    } else {
                                      return const Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            },

                            searchLoaded: (searchResults) => RefreshIndicator(
                              onRefresh: () => context
                                  .read<MarketCoinsCubit>()
                                  .refreshMarketCoins(),
                              child: ListView.builder(
                                itemCount: searchResults.length,
                                itemBuilder: (context, index) {
                                  final result = searchResults[index];
                                  return CoinListItem(
                                    coinUIModel:
                                        CoinMapper.fromSearchCoinResult(result),
                                    onTap: () {
                                      NavigationService.navigateTo(
                                        context,
                                        '${AppRoutes.coinDetails}?id=${result.id}',
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

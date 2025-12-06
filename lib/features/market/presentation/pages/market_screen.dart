import 'dart:async';
import 'dart:developer';

import 'package:fintech/core/di/injection.dart';
import 'package:fintech/features/market/data/mapper/coin_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/navigation/navigation_service.dart';
import '../../../../core/routes/app_routes.dart';
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
                    child: BlocBuilder<MarketCoinsCubit, MarketCoinsState>(
                      builder: (context, state) {
                        return state.when(
                          loading: () =>
                              Center(child: CircularProgressIndicator()),

                          searching: () =>
                              Center(child: CircularProgressIndicator()),

                          error: (message) => Center(
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

                          searchError: (message) => Center(
                            child: Text(
                              'Search Error: $message',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                                fontWeight: FontWeight.w500,
                              ),
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

                          loaded: (coinsMarkets) {
                            return NotificationListener<ScrollNotification>(
                              onNotification: (scrollNotification) {
                                if (scrollNotification.metrics.pixels ==
                                        scrollNotification
                                            .metrics
                                            .maxScrollExtent &&
                                    !context
                                        .read<MarketCoinsCubit>()
                                        .isLoadingMore) {
                                  context
                                      .read<MarketCoinsCubit>()
                                      .getAllCoinsMarkets(loadMore: true);
                                }
                                return false;
                              },
                              child: ListView.builder(
                                itemCount: coinsMarkets.length + 1,
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
                                    return context
                                            .read<MarketCoinsCubit>()
                                            .hasMore
                                        ? const Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                        : const SizedBox.shrink();
                                  }
                                },
                              ),
                            );
                          },

                          searchLoaded: (searchResults) => ListView.builder(
                            itemCount: searchResults.length,
                            itemBuilder: (context, index) {
                              final result = searchResults[index];
                              return CoinListItem(
                                coinUIModel: CoinMapper.fromSearchCoinResult(
                                  result,
                                ),
                                onTap: () {
                                  NavigationService.navigateTo(
                                    context,
                                    '${AppRoutes.coinDetails}?id=${result.id}',
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
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

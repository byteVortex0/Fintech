import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/utils/svg_icon_manager.dart';

import '../widgets/market_search_bar.dart';
import '../widgets/category_filter.dart';
import '../widgets/coin_list_item.dart';
import '../../data/models/market_coin_model.dart';

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

  final List<MarketCoinModel> coins = [
    MarketCoinModel(
      name: 'Bitcoin',
      rank: '1',
      price: '\$54,382.64',
      changePercent: '+15.3%',
      svgIconPath: SvgIconManager.bitcoinIcon,
    ),
    MarketCoinModel(
      name: 'Ethereum',
      rank: '2',
      price: '\$4,145.61',
      changePercent: '-2.1%',
      svgIconPath: SvgIconManager.ethereumIcon,
    ),
    MarketCoinModel(
      name: 'Litecoin',
      rank: '3',
      price: '\$207.3',
      changePercent: '-1.1%',
      svgIconPath: SvgIconManager.liteCoinIcon,
    ),
    MarketCoinModel(
      name: 'Solana',
      rank: '4',
      price: '\$227.93',
      changePercent: '+15.3%',
      svgIconPath: null,
    ),
    MarketCoinModel(
      name: 'Binance Coin',
      rank: '5',
      price: '\$610.5',
      changePercent: '-2.35%',
      svgIconPath: SvgIconManager.topGainerBinanceIcon,
    ),
    MarketCoinModel(
      name: 'Ripple',
      rank: '6',
      price: '\$1.0358',
      changePercent: '+15.3%',
      svgIconPath: null,
    ),
  ];

  List<MarketCoinModel> get filteredCoins {
    return coins.where((coin) {
      final matchesSearch = coin.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Expanded(
              child: filteredCoins.isEmpty
                  ? Center(
                      child: Text(
                        'No coins found',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(bottom: 16.h),
                      itemCount: filteredCoins.length,
                      itemBuilder: (context, index) {
                        return CoinListItem(coin: filteredCoins[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

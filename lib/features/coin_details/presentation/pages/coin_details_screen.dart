import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fintech/core/navigation/navigation_service.dart';
import 'package:fintech/core/routes/app_routes.dart';
import 'package:fintech/core/utils/color_manager.dart';
import 'package:fintech/core/utils/svg_icon_manager.dart';
import 'package:fintech/shared/widgets/app_back_button.dart';
import '../../data/models/coin_details_model.dart';
import '../widgets/coin_header_section.dart';
import '../widgets/price_card_widget.dart';
import '../widgets/chart_section_widget.dart';
import '../widgets/statistics_section.dart';
import '../widgets/about_section.dart';
import '../widgets/action_buttons_section.dart';

/// Coin Details Screen - Displays detailed cryptocurrency information
class CoinDetailsScreen extends StatefulWidget {
  final String coinName;
  final String? svgIconPath;

  const CoinDetailsScreen({
    super.key,
    required this.coinName,
    this.svgIconPath,
  });

  @override
  State<CoinDetailsScreen> createState() => _CoinDetailsScreenState();
}

class _CoinDetailsScreenState extends State<CoinDetailsScreen> {
  String selectedTimePeriod = '1d';

  late final CoinDetailsModel coinDetails;

  @override
  void initState() {
    super.initState();
    coinDetails = CoinDetailsModel(
      name: widget.coinName,
      price: '\$54,382.64',
      pricePerUnit: '/ 1 BTC',
      changePercent: '15.3%',
      isPositive: true,
      svgIconPath: widget.svgIconPath ?? SvgIconManager.bitcoinIcon,
      currentPrice: '44,826,12 \$',
      marketCap: '836,819 \$',
      volume24h: '35,867 \$',
      availableSupply: '18,784',
      maxSupply: '21,000',
      description:
          'Bitcoin is a decentralized cryptocurrency originally described in a 2008 whitepaper by a person, or group of people, using the alias Satoshi Nakamoto. It was launched soon after, in January 2009.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColorManager.screenBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    CoinHeaderSection(
                      name: coinDetails.name,
                      svgIconPath: coinDetails.svgIconPath,
                    ),
                    SizedBox(height: 16.h),
                    PriceCardWidget(
                      price: coinDetails.price,
                      pricePerUnit: coinDetails.pricePerUnit,
                      changePercent: coinDetails.changePercent,
                      isPositive: coinDetails.isPositive,
                    ),
                    SizedBox(height: 20.h),
                    ChartSectionWidget(
                      selectedPeriod: selectedTimePeriod,
                      onPeriodSelected: (period) {
                        setState(() {
                          selectedTimePeriod = period;
                        });
                      },
                    ),
                    SizedBox(height: 24.h),
                    StatisticsSection(
                      currentPrice: coinDetails.currentPrice,
                      marketCap: coinDetails.marketCap,
                      volume24h: coinDetails.volume24h,
                      availableSupply: coinDetails.availableSupply,
                      maxSupply: coinDetails.maxSupply,
                    ),
                    SizedBox(height: 24.h),
                    AboutSection(
                      coinName: coinDetails.name,
                      description: coinDetails.description,
                    ),
                    SizedBox(height: 24.h),
                    ActionButtonsSection(
                      onSellPressed: () {
                        // TODO: Navigate to sell screen
                      },
                      onBuyPressed: () {
                        NavigationService.navigateTo(
                          context,
                          '${AppRoutes.buyCrypto}?coinName=${coinDetails.name}',
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
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
              color: const Color(0xFF1A2B4A),
            ),
          ),
          const Spacer(),
          SizedBox(width: 24.sp),
        ],
      ),
    );
  }
}

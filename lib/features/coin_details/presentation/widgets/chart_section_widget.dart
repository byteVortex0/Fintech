import '../logic/chart_cubit/chart_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/color_manager.dart';
import '../../data/models/coins_chart_respose.dart';

class ChartSectionWidget extends StatefulWidget {
  const ChartSectionWidget({super.key, required this.id});

  final String id;

  @override
  State<ChartSectionWidget> createState() => _ChartSectionWidgetState();
}

class _ChartSectionWidgetState extends State<ChartSectionWidget> {
  String selectedPeriod = '7d';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartCubit, ChartState>(
      builder: (context, state) {
        return state.when(
          loading: () => SizedBox(
            height: 200.h,
            child: Center(child: CircularProgressIndicator()),
          ),
          loaded: (chart, period) {
            final spots = _convertToFlSpots(chart);
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  // Line Chart
                  SizedBox(
                    height: 200.h,
                    child: spots.isEmpty
                        ? Center(child: Text('No chart data available'))
                        : LineChart(
                            LineChartData(
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                              titlesData: FlTitlesData(
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: () {
                                      if (spots.isEmpty) return 1.0;
                                      final first = spots.first.x;
                                      final last = spots.last.x;
                                      final diff = (last - first).abs();
                                      if (diff == 0.0) return 1.0;
                                      return (diff / 4.0).toDouble();
                                    }(),

                                    getTitlesWidget: (value, _) {
                                      final timestamp = value.toInt();
                                      final date =
                                          DateTime.fromMillisecondsSinceEpoch(
                                            timestamp,
                                          );

                                      String label = '';

                                      switch (period) {
                                        case '1h':
                                          label =
                                              '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
                                          break;

                                        case '1d':
                                          label = '${date.hour}:00';
                                          break;

                                        case '1w':
                                        case '1m':
                                          label = '${date.month}/${date.day}';
                                          break;

                                        case '1y':
                                          label = '${date.year}-${date.month}';
                                          break;

                                        default:
                                          label = '${date.month}/${date.day}';
                                      }

                                      return Transform.rotate(
                                        angle: -0.5, // ← حوالى 45 درجة
                                        child: Text(
                                          label,
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium?.color,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: spots,
                                  isCurved: true,
                                  color: LightColorManager.chartsColor,
                                  barWidth: 2,
                                  dotData: FlDotData(show: false),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      colors: [
                                        LightColorManager.chartsColor
                                            .withValues(alpha: 0.3),
                                        LightColorManager.chartsColor
                                            .withValues(alpha: 0.05),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  SizedBox(height: 16.h),
                  // Time period buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTimePeriodButton('1d', context),
                      _buildTimePeriodButton('7d', context),
                      _buildTimePeriodButton('1m', context),
                      _buildTimePeriodButton('1y', context),
                    ],
                  ),
                ],
              ),
            );
          },
          error: (msg) => Center(child: Text(msg)),
        );
      },
    );
  }

  List<FlSpot> _convertToFlSpots(CoinsChartResponse data) {
    if (data.prices.isEmpty) return [];

    return data.prices.map((item) {
      final timestamp = item[0].toDouble();
      final price = item[1].toDouble();
      return FlSpot(timestamp, price);
    }).toList();
  }

  Widget _buildTimePeriodButton(String period, BuildContext context) {
    final isSelected = period == selectedPeriod;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPeriod = period;
        });

        context.read<ChartCubit>().fetchChart(
          coinId: widget.id,
          period: period,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.secondary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          period,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }
}

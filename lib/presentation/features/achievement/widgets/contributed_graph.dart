import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twinfix/core/extensions/datetime_extension.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/entities/deletion_history.dart';
import 'package:twinfix/generated/l10n.dart';

class ContributedGraph extends StatefulWidget {
  final List<DeletionHistory> history;
  final int monthsToShow;

  const ContributedGraph({
    super.key,
    required this.history,
    this.monthsToShow = 12,
  });

  @override
  State<ContributedGraph> createState() => _ContributedGraphState();
}

class _ContributedGraphState extends State<ContributedGraph> {
  bool _isWeekly = false;
  late S _l10n;
  late ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    // Prepare data based on selection
    final now = DateTime.now();
    final List<DateTime> ranges = [];
    final List<double> values = [];

    if (!_isWeekly) {
      // Last 7 Days
      for (int i = 0; i < 7; i++) {
        ranges.add(now.subtract(Duration(days: 6 - i)));
      }

      // Aggregate history for each day
      final Map<String, int> dailyCounts = {};
      for (var item in widget.history) {
        final key = item.timestamp.yearDashMonthDashDay;
        dailyCounts[key] = (dailyCounts[key] ?? 0) + item.totalCount;
      }

      for (var date in ranges) {
        final key = date.yearDashMonthDashDay;
        values.add((dailyCounts[key] ?? 0).toDouble());
      }
    } else {
      // Last 7 Weeks
      final currentMonday = now.subtract(Duration(days: now.weekday - 1));
      for (int i = 0; i < 7; i++) {
        ranges.add(currentMonday.subtract(Duration(days: (6 - i) * 7)));
      }

      // Aggregate history for each week
      for (var weekStart in ranges) {
        final weekEnd = weekStart.add(
          const Duration(days: 6, hours: 23, minutes: 59, seconds: 59),
        );
        double totalInWeek = 0;
        for (var item in widget.history) {
          if (item.timestamp.isAfter(
                weekStart.subtract(const Duration(seconds: 1)),
              ) &&
              item.timestamp.isBefore(
                weekEnd.add(const Duration(seconds: 1)),
              )) {
            totalInWeek += item.totalCount;
          }
        }
        values.add(totalInWeek);
      }
    }

    double maxVal = 0;
    double totalCleaned = 0;
    for (var val in values) {
      totalCleaned += val;
      if (val > maxVal) {
        maxVal = val;
      }
    }

    // Default max Y to 10 if no data
    final maxY = maxVal == 0 ? 10.0 : maxVal * 1.2;

    // Build FlSpot list from values
    final spots = List.generate(
      values.length,
      (i) => FlSpot(i.toDouble(), values[i]),
    );

    final gradientColors = [
      _theme.colorScheme.primary,
      _theme.colorScheme.secondary,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(totalCleaned),
        16.height,
        AspectRatio(
          aspectRatio: 1.7,
          child: Padding(
            padding: const EdgeInsets.only(right: 8, top: 8),
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (spot) =>
                        _theme.colorScheme.primaryContainer,
                    tooltipPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '${spot.y.toInt()} ${_l10n.media_photo.toLowerCase()}',
                          _theme.textTheme.bodySmall?.copyWith(
                                color: _theme.colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                              ) ??
                              const TextStyle(),
                        );
                      }).toList();
                    },
                  ),
                  touchCallback:
                      (FlTouchEvent event, LineTouchResponse? response) {
                        if (event is FlTapUpEvent || event is FlLongPressEnd) {
                          try {
                            HapticFeedback.selectionClick();
                          } catch (_) {}
                        }
                      },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      interval: max(1.0, (maxY / 4).roundToDouble()),
                      getTitlesWidget: _leftTitleWidgets,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 42,
                      interval: 1,
                      getTitlesWidget: _bottomTitleWidgets,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: max(1.0, (maxY / 4).roundToDouble()),
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: _theme.colorScheme.outlineVariant.withValues(
                      alpha: 0.3,
                    ),
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  ),
                ),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    curveSmoothness: 0.3,
                    preventCurveOverShooting: true,
                    gradient: LinearGradient(colors: gradientColors),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: _theme.colorScheme.primary,
                          strokeWidth: 2,
                          strokeColor: _theme.colorScheme.onPrimary,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: gradientColors
                            .map((color) => color.withValues(alpha: 0.15))
                            .toList(),
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(double totalCleaned) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _l10n.contributionGraph,
                style: _theme.textTheme.titleMedium,
              ),
              2.height,
              Text(
                _isWeekly
                    ? _l10n.totalPhotosLast7Weeks(
                        totalCleaned.toInt(),
                        _l10n.media_photo.toLowerCase(),
                      )
                    : _l10n.totalPhotosLast7Days(
                        totalCleaned.toInt(),
                        _l10n.media_photo.toLowerCase(),
                      ),
                style: _theme.textTheme.bodySmall?.copyWith(
                  color: _theme.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.7,
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildFilterToggle(),
      ],
    );
  }

  Widget _buildFilterToggle() {
    return Container(
      padding: 4.paddingAll,
      decoration: BoxDecoration(
        color: _theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.5,
        ),
        borderRadius: 12.borderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton(
            label: _l10n.sevenDays,
            isSelected: !_isWeekly,
            onTap: () {
              setState(() {
                _isWeekly = false;
              });
            },
          ),
          _buildToggleButton(
            label: _l10n.sevenWeeks,
            isSelected: _isWeekly,
            onTap: () {
              setState(() {
                _isWeekly = true;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? _theme.colorScheme.primary : Colors.transparent,
          borderRadius: 8.borderRadius,
        ),
        child: Text(
          label,
          style: _theme.textTheme.bodyMedium?.copyWith(
            color: isSelected
                ? _theme.colorScheme.onPrimary
                : _theme.colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta) {
    if (value == meta.max) return const SizedBox.shrink();
    return SideTitleWidget(
      meta: meta,
      child: Text(
        value.toInt().toString(),
        style: _theme.textTheme.labelSmall?.copyWith(
          color: _theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    final int index = value.toInt();
    if (index < 0 || index > 6) return const SizedBox.shrink();

    if (!_isWeekly) {
      final date = DateTime.now().subtract(Duration(days: 6 - index));
      final weekdayLabel = _getWeekdayLabel(date, _l10n);
      final dateLabel = date.dayMonth;

      return SideTitleWidget(
        meta: meta,
        space: 6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              weekdayLabel,
              style: _theme.textTheme.bodySmall?.copyWith(
                color: _theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              dateLabel,
              style: _theme.textTheme.labelSmall?.copyWith(
                color: _theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.6,
                ),
                fontSize: 8,
              ),
            ),
          ],
        ),
      );
    } else {
      final now = DateTime.now();
      final currentMonday = now.subtract(Duration(days: now.weekday - 1));
      final weekStart = currentMonday.subtract(Duration(days: (6 - index) * 7));
      final weekEnd = weekStart.add(const Duration(days: 6));
      final rangeLabel = "${weekStart.dayMonth}-${weekEnd.dayMonth}";

      return SideTitleWidget(
        meta: meta,
        space: 6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${_l10n.weekShort} ${index + 1}",
              style: _theme.textTheme.bodySmall?.copyWith(
                color: _theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              rangeLabel,
              style: _theme.textTheme.labelSmall?.copyWith(
                color: _theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.6,
                ),
                fontSize: 8,
              ),
            ),
          ],
        ),
      );
    }
  }

  String _getWeekdayLabel(DateTime date, S l10n) {
    switch (date.weekday) {
      case DateTime.monday:
        return l10n.mon;
      case DateTime.tuesday:
        return l10n.tue;
      case DateTime.wednesday:
        return l10n.wed;
      case DateTime.thursday:
        return l10n.thu;
      case DateTime.friday:
        return l10n.fri;
      case DateTime.saturday:
        return l10n.sat;
      case DateTime.sunday:
        return l10n.sun;
      default:
        return '';
    }
  }
}

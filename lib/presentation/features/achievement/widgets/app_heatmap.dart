import 'dart:math';
import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/datetime_extension.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/entities/deletion_history.dart';
import 'package:twinfix/generated/l10n.dart';

class AppHeatMap extends StatefulWidget {
  final List<DeletionHistory> history;
  final int monthsToShow;

  const AppHeatMap({super.key, required this.history, this.monthsToShow = 12});

  @override
  State<AppHeatMap> createState() => _AppHeatMapState();
}

class _AppHeatMapState extends State<AppHeatMap> {
  late PageController _pageController;
  late List<DateTime> _months;
  int _currentPage = 0;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    _months = List.generate(widget.monthsToShow, (i) {
      return DateTime(now.year, i + 1, 1);
    });
    _currentPage = (now.month - 1).clamp(0, widget.monthsToShow - 1);
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    // Normalize history to date-only keys
    final Map<String, int> historyMap = {};
    for (var item in widget.history) {
      final key = item.timestamp.yearDashMonthDashDay;
      historyMap[key] = (historyMap[key] ?? 0) + 1;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        16.height,
        LayoutBuilder(
          builder: (context, constraints) {
            final cellSize = (constraints.maxWidth - 6 * _spacing) / 7;
            final gridHeight = _maxWeekRows * (cellSize + _spacing) - _spacing;

            return Column(
              children: [
                _buildDayLabelsRow(cellSize),
                6.height,
                SizedBox(
                  height: gridHeight,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemCount: _months.length,
                    itemBuilder: (context, index) {
                      final month = _months[index];
                      final monthStart = DateTime(month.year, month.month, 1);
                      final monthEnd = DateTime(month.year, month.month + 1, 0);

                      return CustomPaint(
                        painter: HeatMapPainter(
                          startDate: monthStart,
                          endDate: monthEnd,
                          historyMap: historyMap,
                          primaryColor: _theme.colorScheme.primary,
                          baseColor: _theme.colorScheme.surfaceContainerHighest,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
        8.height,
        _buildLegend(),
      ],
    );
  }

  /// Max number of week-rows a month can span (6 weeks)
  static const int _maxWeekRows = 6;
  static const double _spacing = 4;

  Widget _buildHeader() {
    final currentMonth = _months[_currentPage];
    final monthName = currentMonth.monthYear;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(monthName, style: _theme.textTheme.titleMedium),
        Row(
          children: [
            IconButton(
              onPressed: _currentPage > 0
                  ? () => _pageController.previousPage(
                      duration: 300.milliseconds,
                      curve: Curves.easeInOut,
                    )
                  : () {},
              icon: const Icon(Icons.chevron_left),
              constraints: const BoxConstraints(),
            ),
            16.width,
            IconButton(
              onPressed: _currentPage < _months.length - 1
                  ? () => _pageController.nextPage(
                      duration: 300.milliseconds,
                      curve: Curves.easeInOut,
                    )
                  : () {},
              icon: const Icon(Icons.chevron_right),
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDayLabelsRow(double cellSize) {
    final days = [
      _l10n.mon,
      _l10n.tue,
      _l10n.wed,
      _l10n.thu,
      _l10n.fri,
      _l10n.sat,
      _l10n.sun,
    ];
    return Row(
      children: List.generate(7, (i) {
        return Container(
          width: cellSize + (i < 6 ? _spacing : 0),
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: i < 6 ? _spacing : 0),
          child: Text(
            days[i],
            textAlign: TextAlign.center,
            style: _theme.textTheme.bodyMedium,
          ),
        );
      }),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(_l10n.less, style: _theme.textTheme.bodySmall),
        4.width,
        ...List.generate(
          4,
          (i) => Container(
            width: 10,
            height: 10,
            margin: 2.paddingHorizontal,
            decoration: BoxDecoration(
              color: _theme.colorScheme.primary.withValues(
                alpha: 0.1 + (i * 0.3),
              ),
              borderRadius: 2.borderRadius,
            ),
          ),
        ),
        4.width,
        Text(_l10n.more, style: _theme.textTheme.bodySmall),
      ],
    );
  }
}

class HeatMapPainter extends CustomPainter {
  final DateTime startDate;
  final DateTime endDate;
  final Map<String, int> historyMap;
  final Color primaryColor;
  final Color baseColor;

  HeatMapPainter({
    required this.startDate,
    required this.endDate,
    required this.historyMap,
    required this.primaryColor,
    required this.baseColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double spacing = 4;
    final double cellSize = (size.width - 6 * spacing) / 7;
    final Paint paint = Paint();

    DateTime current = startDate;

    // startCol = weekday index (Mon=0 .. Sun=6)
    int startCol = current.weekday - 1;
    int col = startCol;
    int row = 0;

    while (current.isBefore(endDate.add(1.days))) {
      final dateKey = current.yearDashMonthDashDay;
      final count = historyMap[dateKey] ?? 0;

      paint.color = count > 0
          ? primaryColor.withValues(alpha: min(1.0, 0.3 + (count * 0.2)))
          : baseColor;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            col * (cellSize + spacing),
            row * (cellSize + spacing),
            cellSize,
            cellSize,
          ),
          const Radius.circular(4),
        ),
        paint,
      );

      col++;
      if (col == 7) {
        col = 0;
        row++;
      }
      current = current.add(1.days);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

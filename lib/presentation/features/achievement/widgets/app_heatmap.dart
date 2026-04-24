import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twinfix/domain/entities/deletion_history.dart';

class AppHeatMap extends StatefulWidget {
  final List<DeletionHistory> history;
  final int monthsToShow;

  const AppHeatMap({
    super.key,
    required this.history,
    this.monthsToShow = 12,
  });

  @override
  State<AppHeatMap> createState() => _AppHeatMapState();
}

class _AppHeatMapState extends State<AppHeatMap> {
  late PageController _pageController;
  late List<DateTime> _months;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.monthsToShow - 1;
    _pageController = PageController(initialPage: _currentPage);
    
    final now = DateTime.now();
    _months = List.generate(widget.monthsToShow, (i) {
      return DateTime(now.year, now.month - (widget.monthsToShow - 1 - i), 1);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Normalize history to date-only keys
    final Map<String, int> historyMap = {};
    for (var item in widget.history) {
      final key = DateFormat('yyyy-MM-dd').format(item.timestamp);
      historyMap[key] = (historyMap[key] ?? 0) + 1;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(theme),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDaysLabels(),
              const SizedBox(width: 12),
              Expanded(
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
                        primaryColor: theme.colorScheme.primary,
                        baseColor: theme.colorScheme.surfaceContainerHighest,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildLegend(theme),
      ],
    );
  }

  Widget _buildHeader(ThemeData theme) {
    final currentMonth = _months[_currentPage];
    final monthName = DateFormat('MMMM yyyy').format(currentMonth);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          monthName,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: _currentPage > 0 
                ? () => _pageController.previousPage(
                    duration: const Duration(milliseconds: 300), 
                    curve: Curves.easeInOut,
                  ) 
                : null,
              icon: const Icon(Icons.chevron_left),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: _currentPage < _months.length - 1 
                ? () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 300), 
                    curve: Curves.easeInOut,
                  ) 
                : null,
              icon: const Icon(Icons.chevron_right),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDaysLabels() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Mon', style: TextStyle(fontSize: 10, color: Colors.grey)),
        Text('Wed', style: TextStyle(fontSize: 10, color: Colors.grey)),
        Text('Fri', style: TextStyle(fontSize: 10, color: Colors.grey)),
        SizedBox(height: 2), // Spacing for alignment
      ],
    );
  }

  Widget _buildLegend(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text('Less', style: TextStyle(fontSize: 10, color: Colors.grey)),
        const SizedBox(width: 4),
        ...List.generate(4, (i) => Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1 + (i * 0.3)),
            borderRadius: BorderRadius.circular(2),
          ),
        )),
        const SizedBox(width: 4),
        const Text('More', style: TextStyle(fontSize: 10, color: Colors.grey)),
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
    const double cellSize = 14;
    const double spacing = 4;
    final Paint paint = Paint();

    // Start with the first day of the month
    DateTime current = startDate;
    
    // Find the weekday of the first day (Monday = 1, Sunday = 7)
    // We want to align it in the grid.
    // GitHub HeatMap: rows are days of week (0=Mon, 6=Sun)
    
    int startRow = current.weekday - 1; 
    int col = 0;
    int row = startRow;

    while (current.isBefore(endDate.add(const Duration(days: 1)))) {
      final dateKey = DateFormat('yyyy-MM-dd').format(current);
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
          const Radius.circular(3),
        ),
        paint,
      );

      row++;
      if (row == 7) {
        row = 0;
        col++;
      }
      current = current.add(const Duration(days: 1));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

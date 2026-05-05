import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twinfix/core/configs/app_configs.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';

class ScanLimitBottomSheet extends StatefulWidget {
  final int initialLimit;
  final Function(int) onLimitChanged;

  const ScanLimitBottomSheet({
    super.key,
    required this.initialLimit,
    required this.onLimitChanged,
  });

  @override
  State<ScanLimitBottomSheet> createState() => _ScanLimitBottomSheetState();
}

class _ScanLimitBottomSheetState extends State<ScanLimitBottomSheet> {
  final List<int> _limits = AppConfigs.scanLimitOptions;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = _limits.indexOf(widget.initialLimit);
    if (_selectedIndex == -1) _selectedIndex = 2; // Default to 200
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);
    final isAllSelected = _limits[_selectedIndex] == 0;

    return SafeArea(
      child: Container(
        height: 280,
        padding: 12.paddingAll,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.scanLimit, style: theme.textTheme.titleLarge),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    l10n.done,
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 45,
                scrollController: FixedExtentScrollController(
                  initialItem: _selectedIndex,
                ),
                onSelectedItemChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  widget.onLimitChanged(_limits[index]);
                },
                children: _limits.map((limit) {
                  return Center(
                    child: Text(
                      limit == 0 ? l10n.scanLimitAll : limit.toString(),
                      style: theme.textTheme.titleMedium,
                    ),
                  );
                }).toList(),
              ),
            ),
            if (isAllSelected) ...[
              Container(
                height: 50,
                padding: 8.paddingAll,
                decoration: BoxDecoration(
                  color: Colors.redAccent.withValues(alpha: 0.1),
                  borderRadius: 12.borderRadius,
                  border: Border.all(
                    color: Colors.redAccent.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.redAccent,
                      size: 20,
                    ),
                    12.width,
                    Expanded(
                      child: Text(
                        l10n.scanLimitWarning,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              50.height,
            ],
          ],
        ),
      ),
    );
  }
}

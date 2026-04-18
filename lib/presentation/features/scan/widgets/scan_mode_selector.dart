import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/scan_mode.dart';
import '../../../../core/extensions/extensions.dart';

class ScanModeSelector extends StatelessWidget {
  final ScanMode currentMode;
  final ValueChanged<ScanMode> onModeChanged;
  final String quickScanLabel;
  final String deepScanLabel;

  const ScanModeSelector({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
    required this.quickScanLabel,
    required this.deepScanLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: 4.paddingAll,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: 30.borderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ModeButton(
            label: quickScanLabel,
            isSelected: currentMode == ScanMode.quick,
            onTap: () => onModeChanged(ScanMode.quick),
          ),
          _ModeButton(
            label: deepScanLabel,
            isSelected: currentMode == ScanMode.deep,
            onTap: () => onModeChanged(ScanMode.deep),
          ),
        ],
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        if (isSelected) return;
        onTap();
      },
      child: AnimatedContainer(
        duration: 200.milliseconds,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.surface : Colors.transparent,
          borderRadius: 26.borderRadius,
          boxShadow: isSelected
              ? [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

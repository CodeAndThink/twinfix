import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/extensions.dart';

class BenefitRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const BenefitRow({
    super.key,
    required this.icon,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, color: color),
        10.width,
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 15),
          ),
        ),
      ],
    );
  }
}

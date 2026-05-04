import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/generated/l10n.dart';

class PackageCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final VoidCallback onTap;
  final bool isPopular;

  const PackageCard({
    super.key,
    required this.title,
    required this.price,
    required this.description,
    required this.onTap,
    required this.isPopular,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.milliseconds,
        decoration: BoxDecoration(
          borderRadius: 20.borderRadius,
          border: Border.all(
            color: isPopular
                ? theme.colorScheme.primary
                : theme.colorScheme.outlineVariant,
            width: isPopular ? 2 : 1,
          ),
          color: isPopular
              ? theme.colorScheme.primary.withValues(alpha: 0.05)
              : theme.colorScheme.surface,
          boxShadow: [
            if (isPopular)
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            if (!isPopular)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: 20.0.padding,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: isPopular ? theme.colorScheme.primary : null,
                          ),
                        ),
                        4.height,
                        Text(
                          description,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        price,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: isPopular ? theme.colorScheme.primary : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isPopular)
              Positioned(
                top: 0,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: 10.borderRadiusTop,
                  ),
                  child: Text(
                    l10n.popular,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

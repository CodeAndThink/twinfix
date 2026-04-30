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

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: 16.borderRadius,
          border: Border.all(
            color: isPopular ? Colors.deepPurple : Colors.grey.shade300,
            width: isPopular ? 2 : 1,
          ),
          color: isPopular
              ? Colors.deepPurple.withValues(alpha: 0.05)
              : Colors.transparent,
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
                            fontWeight: FontWeight.bold,
                            color: isPopular ? theme.colorScheme.primary : null,
                          ),
                        ),
                        4.height,
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    price,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isPopular ? Colors.deepPurple : null,
                      fontWeight: FontWeight.bold,
                    ),
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
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: 8.borderRadiusBottom,
                  ),
                  child: Text(
                    l10n.popular,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
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

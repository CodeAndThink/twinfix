import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/presentation/app/cubit/theme_cubit.dart';
import 'package:twinfix/core/enums/background_type.dart';
import 'package:twinfix/presentation/widgets/images/app_file_image.dart';

class ThemeListItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final BackgroundType type;

  const ThemeListItem({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 70,
      height: 140,
      child: InkWell(
        borderRadius: 16.borderRadius,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: 16.borderRadius,
                border: Border.all(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outlineVariant,
                  width: 2,
                ),
                color: theme.cardColor,
              ),
              child: ClipRRect(
                borderRadius: 14.borderRadius,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (!type.isNone)
                      type.isCustom
                          ? (context
                                        .read<ThemeCubit>()
                                        .state
                                        .customBackgroundPath ==
                                    null
                                ? const SizedBox.shrink()
                                : AppFileImage(
                                    path: context
                                        .read<ThemeCubit>()
                                        .state
                                        .customBackgroundPath!,
                                    fit: BoxFit.cover,
                                  ))
                          : Image.asset(
                              (theme.brightness == Brightness.dark
                                      ? type.darkBackgroundPath
                                      : type.lightBackgroundPath) ??
                                  '',
                              fit: BoxFit.cover,
                            ),
                    if (isSelected)
                      Center(
                        child: Icon(
                          Icons.check_circle,
                          color: theme.colorScheme.primary,
                          size: 32,
                        ),
                      )
                    else if (type.isCustom &&
                        context.read<ThemeCubit>().state.customBackgroundPath ==
                            null)
                      Center(
                        child: Icon(
                          Icons.add_photo_alternate_outlined,
                          color: theme.colorScheme.onSurfaceVariant,
                          size: 32,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            8.height,
            Text(
              type.getName(context).capitalize,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: isSelected ? FontWeight.normal : FontWeight.bold,
                color: isSelected ? theme.colorScheme.primary : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

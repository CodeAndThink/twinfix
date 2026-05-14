import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/presentation/app/cubit/theme_cubit.dart';
import 'package:twinfix/core/enums/background_type.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
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
                image: !type.isNone
                    ? DecorationImage(
                        image: type.isCustom
                            ? (context
                                              .read<ThemeCubit>()
                                              .state
                                              .customBackgroundPath !=
                                          null
                                      ? AppFileImage(
                                          path: context
                                              .read<ThemeCubit>()
                                              .state
                                              .customBackgroundPath!,
                                        )
                                      : const AssetImage(''))
                                  as ImageProvider
                            : AssetImage(
                                (theme.brightness == Brightness.dark
                                        ? type.darkBackgroundPath
                                        : type.lightBackgroundPath) ??
                                    '',
                              ),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: type.isNone ? theme.cardColor : null,
              ),
              child: isSelected
                  ? Center(
                      child: Icon(
                        Icons.check_circle,
                        color: theme.colorScheme.primary,
                        size: 32,
                      ),
                    )
                  : (type.isCustom &&
                        context.read<ThemeCubit>().state.customBackgroundPath ==
                            null)
                  ? Center(
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        color: theme.colorScheme.onSurfaceVariant,
                        size: 32,
                      ),
                    )
                  : null,
            ),
            8.height,
            Text(
              type.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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

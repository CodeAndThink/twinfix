import 'package:flutter/material.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/features/watermark/cubit/watermark_cubit.dart';
import 'package:twinfix/presentation/features/watermark/cubit/watermark_state.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';

class WatermarkBottomBar extends StatelessWidget {
  final WatermarkState state;
  final WatermarkCubit cubit;
  final VoidCallback onSavePressed;

  const WatermarkBottomBar({
    super.key,
    required this.state,
    required this.cubit,
    required this.onSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return AppTransparentContainer(
      height: 72 + MediaQuery.of(context).padding.bottom,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Row(
            children: [
              IconButton(
                onPressed: cubit.pickImage,
                icon: const Icon(Icons.add_photo_alternate_outlined),
                style: IconButton.styleFrom(
                  backgroundColor: theme.colorScheme.surface.withValues(
                    alpha: 0.5,
                  ),
                  padding: 12.paddingAll,
                ),
              ),
              12.width,
              Expanded(
                child: AppFilledButton(
                  text: l10n.save,
                  enabled: state.text.isNotEmpty && !state.status.isLoading,
                  onPressed: onSavePressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

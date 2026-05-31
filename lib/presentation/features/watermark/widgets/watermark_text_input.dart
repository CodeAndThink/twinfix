import 'package:flutter/material.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';

class WatermarkTextInput extends StatelessWidget {
  final TextEditingController controller;

  const WatermarkTextInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return AppTransparentContainer(
      padding: 4.paddingHorizontal,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: l10n.enterWatermarkText,
          border: InputBorder.none,
          contentPadding: 12.paddingAll,
        ),
      ),
    );
  }
}

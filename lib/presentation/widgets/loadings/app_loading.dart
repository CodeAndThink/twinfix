import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/extensions.dart';

class AppLoading extends StatelessWidget {
  final double size;
  final Color? color;

  const AppLoading({super.key, this.size = 40.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: size.square(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
          strokeWidth: 3,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

part 'theme_state.dart';

@lazySingleton
class ThemeCubit extends BaseCubit<ThemeState> {
  ThemeCubit() : super(const ThemeInitial());

  void toggleTheme() {
    if (state.themeMode == ThemeMode.light) {
      updateTheme(ThemeMode.dark);
    } else {
      updateTheme(ThemeMode.light);
    }
  }

  void updateTheme(ThemeMode mode) {
    safeEmit(ThemeChanged(mode));
  }
}

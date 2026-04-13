import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinfix/presentation/app/cubit/theme_state.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

@lazySingleton
class ThemeCubit extends BaseCubit<ThemeState> {
  final SharedPreferences _prefs;

  ThemeCubit(this._prefs) : super(_loadInitialState(_prefs));

  static ThemeState _loadInitialState(SharedPreferences prefs) {
    final themeIndex = prefs.getInt('theme_mode') ?? ThemeMode.system.index;
    final bgIndex =
        prefs.getInt('background_type') ?? BackgroundType.none.index;

    return ThemeState(
      themeMode: ThemeMode.values[themeIndex],
      backgroundType: BackgroundType.values[bgIndex],
    );
  }

  void updateTheme({required ThemeMode mode}) {
    _prefs.setInt('theme_mode', mode.index);
    safeEmit(state.copyWith(themeMode: mode));
  }

  void updateBackground({required BackgroundType type}) {
    _prefs.setInt('background_type', type.index);
    safeEmit(state.copyWith(backgroundType: type));
  }

  void toggleTheme() {
    if (state.themeMode == ThemeMode.light) {
      updateTheme(mode: ThemeMode.dark);
    } else {
      updateTheme(mode: ThemeMode.light);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinfix/core/constants/key_constants.dart';
import 'package:twinfix/core/enums/background_type.dart';
import 'package:twinfix/presentation/app/cubit/theme_state.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

@lazySingleton
class ThemeCubit extends BaseCubit<ThemeState> {
  final SharedPreferences _prefs;

  ThemeCubit(this._prefs) : super(_loadInitialState(_prefs));

  static ThemeState _loadInitialState(SharedPreferences prefs) {
    final themeIndex =
        prefs.getInt(KeyConstants.themeMode) ?? ThemeMode.system.index;
    final bgIndex =
        prefs.getInt(KeyConstants.backgroundType) ?? BackgroundType.none.index;

    return ThemeState(
      themeMode: ThemeMode.values[themeIndex],
      backgroundType: BackgroundType.values[bgIndex],
    );
  }

  void updateTheme({required ThemeMode mode}) {
    _prefs.setInt(KeyConstants.themeMode, mode.index);
    safeEmit(state.copyWith(themeMode: mode));
  }

  void updateBackground({required BackgroundType type}) {
    _prefs.setInt(KeyConstants.backgroundType, type.index);
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

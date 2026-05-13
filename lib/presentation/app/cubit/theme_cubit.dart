import 'package:image_picker/image_picker.dart';
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
    final customPath = prefs.getString(KeyConstants.customBackgroundPath);

    return ThemeState(
      themeMode: ThemeMode.values[themeIndex],
      backgroundType: BackgroundType.values[bgIndex],
      customBackgroundPath: customPath,
    );
  }

  void updateTheme({required ThemeMode mode}) {
    _prefs.setInt(KeyConstants.themeMode, mode.index);
    safeEmit(state.copyWith(themeMode: mode));
  }

  void updateBackground({required BackgroundType type, String? customPath}) {
    _prefs.setInt(KeyConstants.backgroundType, type.index);
    if (customPath != null) {
      _prefs.setString(KeyConstants.customBackgroundPath, customPath);
    }
    safeEmit(state.copyWith(
      backgroundType: type,
      customBackgroundPath: customPath ?? state.customBackgroundPath,
    ));
  }

  Future<void> pickCustomBackground() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      updateBackground(
        type: BackgroundType.custom,
        customPath: image.path,
      );
    }
  }

  void toggleTheme() {
    if (state.themeMode == ThemeMode.light) {
      updateTheme(mode: ThemeMode.dark);
    } else {
      updateTheme(mode: ThemeMode.light);
    }
  }
}

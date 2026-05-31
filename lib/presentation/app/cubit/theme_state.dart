import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/background_type.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final BackgroundType backgroundType;
  final String? customBackgroundPath;

  const ThemeState({
    this.themeMode = ThemeMode.system,
    this.backgroundType = BackgroundType.none,
    this.customBackgroundPath,
  });

  ThemeState copyWith({
    ThemeMode? themeMode,
    BackgroundType? backgroundType,
    String? customBackgroundPath,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      backgroundType: backgroundType ?? this.backgroundType,
      customBackgroundPath: customBackgroundPath ?? this.customBackgroundPath,
    );
  }

  @override
  List<Object?> get props => [themeMode, backgroundType, customBackgroundPath];
}

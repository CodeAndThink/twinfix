import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:twinfix/core/enums/background_type.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final BackgroundType backgroundType;

  const ThemeState({
    this.themeMode = ThemeMode.system,
    this.backgroundType = BackgroundType.none,
  });

  ThemeState copyWith({ThemeMode? themeMode, BackgroundType? backgroundType}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      backgroundType: backgroundType ?? this.backgroundType,
    );
  }

  @override
  List<Object?> get props => [themeMode, backgroundType];
}

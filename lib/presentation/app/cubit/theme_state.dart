part of 'theme_cubit.dart';

abstract class ThemeState {
  final ThemeMode themeMode;
  const ThemeState(this.themeMode);
}

class ThemeInitial extends ThemeState {
  const ThemeInitial() : super(ThemeMode.system);
}

class ThemeChanged extends ThemeState {
  const ThemeChanged(super.themeMode);
}

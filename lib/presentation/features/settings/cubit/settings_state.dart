import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final int maxLimitScanPhoto;
  final bool hasNotificationPermission;

  const SettingsState({
    this.maxLimitScanPhoto = 200,
    this.hasNotificationPermission =
        true, // Default to true so it doesn't flash before checking
  });

  SettingsState copyWith({
    int? maxLimitScanPhoto,
    bool? hasNotificationPermission,
  }) {
    return SettingsState(
      maxLimitScanPhoto: maxLimitScanPhoto ?? this.maxLimitScanPhoto,
      hasNotificationPermission:
          hasNotificationPermission ?? this.hasNotificationPermission,
    );
  }

  @override
  List<Object?> get props => [maxLimitScanPhoto, hasNotificationPermission];
}

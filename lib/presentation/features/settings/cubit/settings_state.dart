import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final int maxLimitScanPhoto;

  const SettingsState({this.maxLimitScanPhoto = 200});

  SettingsState copyWith({int? maxLimitScanPhoto}) {
    return SettingsState(
      maxLimitScanPhoto: maxLimitScanPhoto ?? this.maxLimitScanPhoto,
    );
  }

  @override
  List<Object?> get props => [maxLimitScanPhoto];
}

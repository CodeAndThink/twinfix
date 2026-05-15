import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';

class ProfileSettingsState extends Equatable {
  final LoadStatus loadStatus;
  final LoadStatus updateStatus;
  final String name;
  final String email;
  final String avatarUrl;
  final String frameUrl;
  final String? errorMessage;

  const ProfileSettingsState({
    this.loadStatus = LoadStatus.initial,
    this.updateStatus = LoadStatus.initial,
    this.name = '',
    this.email = '',
    this.avatarUrl = '',
    this.frameUrl = '',
    this.errorMessage,
  });

  ProfileSettingsState copyWith({
    LoadStatus? loadStatus,
    LoadStatus? updateStatus,
    String? name,
    String? email,
    String? avatarUrl,
    String? frameUrl,
    String? errorMessage,
  }) {
    return ProfileSettingsState(
      loadStatus: loadStatus ?? this.loadStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      frameUrl: frameUrl ?? this.frameUrl,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    loadStatus,
    updateStatus,
    name,
    email,
    avatarUrl,
    frameUrl,
    errorMessage,
  ];
}

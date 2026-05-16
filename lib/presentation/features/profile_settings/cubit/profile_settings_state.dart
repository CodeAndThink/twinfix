import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/avatar_frame_type.dart';
import 'package:twinfix/core/enums/avatar_type.dart';
import 'package:twinfix/core/enums/load_status.dart';

class ProfileSettingsState extends Equatable {
  final LoadStatus loadStatus;
  final LoadStatus updateStatus;
  final String name;
  final String email;
  final AvatarType avatarType;
  final AvatarFrameType frameType;
  final bool isGoogleLogin;

  const ProfileSettingsState({
    this.loadStatus = LoadStatus.initial,
    this.updateStatus = LoadStatus.initial,
    this.name = '',
    this.email = '',
    this.avatarType = AvatarType.crocodile0,
    this.frameType = AvatarFrameType.none,
    this.isGoogleLogin = false,
  });

  ProfileSettingsState copyWith({
    LoadStatus? loadStatus,
    LoadStatus? updateStatus,
    String? name,
    String? email,
    AvatarType? avatarType,
    AvatarFrameType? frameType,
    bool? isGoogleLogin,
  }) {
    return ProfileSettingsState(
      loadStatus: loadStatus ?? this.loadStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarType: avatarType ?? this.avatarType,
      frameType: frameType ?? this.frameType,
      isGoogleLogin: isGoogleLogin ?? this.isGoogleLogin,
    );
  }

  @override
  List<Object?> get props => [
    loadStatus,
    updateStatus,
    name,
    email,
    avatarType,
    frameType,
    isGoogleLogin,
  ];
}

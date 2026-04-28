import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';

class ProfileDetailState extends Equatable {
  final LoadStatus loadStatus;
  final String name;
  final String email;
  final String avatarUrl;
  final bool isLoggedOut;
  final String? errorMessage;

  const ProfileDetailState({
    this.loadStatus = LoadStatus.initial,
    this.name = '',
    this.email = '',
    this.avatarUrl = '',
    this.isLoggedOut = false,
    this.errorMessage,
  });

  ProfileDetailState copyWith({
    LoadStatus? loadStatus,
    String? name,
    String? email,
    String? avatarUrl,
    bool? isLoggedOut,
    String? errorMessage,
  }) {
    return ProfileDetailState(
      loadStatus: loadStatus ?? this.loadStatus,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    loadStatus,
    name,
    email,
    avatarUrl,
    isLoggedOut,
    errorMessage,
  ];
}

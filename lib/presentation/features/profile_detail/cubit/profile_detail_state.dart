import 'package:equatable/equatable.dart';
import 'package:twinfix/core/enums/load_status.dart';

class ProfileDetailState extends Equatable {
  final LoadStatus loadStatus;
  final String name;
  final String email;
  final String avatarUrl;
  final bool isLoggedOut;
  final String? errorMessage;

  // Stats
  final int totalCleanedBytes;
  final int streakDays;
  final int totalDeletedPhotos;
  final int blurryDeletedPhotos;
  final int duplicateDeletedPhotos;
  final int maxDeletedInOneSession;
  final bool isPro;
  final List<String> badgeIds;

  const ProfileDetailState({
    this.loadStatus = LoadStatus.initial,
    this.name = '',
    this.email = '',
    this.avatarUrl = '',
    this.isLoggedOut = false,
    this.errorMessage,
    this.totalCleanedBytes = 0,
    this.streakDays = 0,
    this.totalDeletedPhotos = 0,
    this.blurryDeletedPhotos = 0,
    this.duplicateDeletedPhotos = 0,
    this.maxDeletedInOneSession = 0,
    this.isPro = false,
    this.badgeIds = const [],
  });

  ProfileDetailState copyWith({
    LoadStatus? loadStatus,
    String? name,
    String? email,
    String? avatarUrl,
    bool? isLoggedOut,
    String? errorMessage,
    int? totalCleanedBytes,
    int? streakDays,
    int? totalDeletedPhotos,
    int? blurryDeletedPhotos,
    int? duplicateDeletedPhotos,
    int? maxDeletedInOneSession,
    bool? isPro,
    List<String>? badgeIds,
  }) {
    return ProfileDetailState(
      loadStatus: loadStatus ?? this.loadStatus,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
      errorMessage: errorMessage ?? this.errorMessage,
      totalCleanedBytes: totalCleanedBytes ?? this.totalCleanedBytes,
      streakDays: streakDays ?? this.streakDays,
      totalDeletedPhotos: totalDeletedPhotos ?? this.totalDeletedPhotos,
      blurryDeletedPhotos: blurryDeletedPhotos ?? this.blurryDeletedPhotos,
      duplicateDeletedPhotos:
          duplicateDeletedPhotos ?? this.duplicateDeletedPhotos,
      maxDeletedInOneSession:
          maxDeletedInOneSession ?? this.maxDeletedInOneSession,
      isPro: isPro ?? this.isPro,
      badgeIds: badgeIds ?? this.badgeIds,
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
    totalCleanedBytes,
    streakDays,
    totalDeletedPhotos,
    blurryDeletedPhotos,
    duplicateDeletedPhotos,
    maxDeletedInOneSession,
    isPro,
    badgeIds,
  ];
}

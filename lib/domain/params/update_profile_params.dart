class UpdateProfileParams {
  final String? fullName;
  final int? avatarType;
  final int? frameType;

  UpdateProfileParams({this.fullName, this.avatarType, this.frameType});

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'avatar_type': avatarType,
      'frame_type': frameType,
    };
  }
}

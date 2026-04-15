import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/generated/l10n.dart';

enum MediaType {
  photo,
  video,
  audio,
  other;

  bool get isPhoto => this == MediaType.photo;
  bool get isVideo => this == MediaType.video;
  bool get isAudio => this == MediaType.audio;
  bool get isOther => this == MediaType.other;
}

extension MediaTypeExtension on MediaType {
  String get label {
    switch (this) {
      case MediaType.photo:
        return S.current.media_photo;
      case MediaType.video:
        return S.current.media_video;
      case MediaType.audio:
        return S.current.media_audio;
      case MediaType.other:
        return S.current.media_other;
    }
  }

  IconData get icon {
    switch (this) {
      case MediaType.photo:
        return Icons.photo;
      case MediaType.video:
        return Icons.video_collection;
      case MediaType.audio:
        return Icons.audio_file;
      case MediaType.other:
        return Icons.more_horiz;
    }
  }

  RequestType get requestType {
    switch (this) {
      case MediaType.photo:
        return RequestType.image;
      case MediaType.video:
        return RequestType.video;
      case MediaType.audio:
        return RequestType.audio;
      case MediaType.other:
        return RequestType.common;
    }
  }

  Color get color {
    switch (this) {
      case MediaType.photo:
        return AppColors.seed;
      case MediaType.video:
        return Colors.purple;
      case MediaType.audio:
        return Colors.orange;
      case MediaType.other:
        return Colors.grey;
    }
  }
}

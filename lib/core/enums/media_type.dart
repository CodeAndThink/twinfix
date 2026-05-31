import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/core/constants/app_colors.dart';
import 'package:twinfix/generated/l10n.dart';

enum MediaType {
  image,
  video,
  audio,
  other;

  bool get isImage => this == MediaType.image;
  bool get isVideo => this == MediaType.video;
  bool get isAudio => this == MediaType.audio;
  bool get isOther => this == MediaType.other;
}

extension MediaTypeExtension on MediaType {
  String get label {
    switch (this) {
      case MediaType.image:
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
      case MediaType.image:
        return Icons.photo;
      case MediaType.video:
        return Icons.video_collection;
      case MediaType.audio:
        return Icons.audio_file;
      case MediaType.other:
        return Icons.perm_media;
    }
  }

  RequestType get requestType {
    switch (this) {
      case MediaType.image:
        return RequestType.image;
      case MediaType.video:
        return RequestType.video;
      case MediaType.audio:
        return RequestType.audio;
      case MediaType.other:
        return RequestType.all;
    }
  }

  Color get color {
    switch (this) {
      case MediaType.image:
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

MediaType getMediaTypeFromValue({int? value}) {
  switch (value) {
    case 1:
      return MediaType.image;
    case 2:
      return MediaType.video;
    case 3:
      return MediaType.audio;
    default:
      return MediaType.other;
  }
}

MediaType getMediaTypeFromAssetType({AssetType? type}) {
  switch (type) {
    case AssetType.image:
      return MediaType.image;
    case AssetType.video:
      return MediaType.video;
    case AssetType.audio:
      return MediaType.audio;
    case AssetType.other:
      return MediaType.other;
    default:
      return MediaType.other;
  }
}

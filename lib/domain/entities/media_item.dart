import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/core/enums/media_type.dart';

import '../enums/photo_type.dart';

class MediaItem {
  final String id;
  final String path;
  final int sizeBytes;
  final DateTime createDateTime;
  final PhotoType type;
  final MediaType mediaType;
  final int width;
  final int height;
  final String? groupId;
  final int duration;
  final int? orientation;
  final bool? isFavorite;
  final String? title;
  final int? createDateSecond;
  final int? modifiedDateSecond;
  final String? relativePath;

  const MediaItem({
    required this.id,
    required this.path,
    this.sizeBytes = 0,
    required this.createDateTime,
    required this.width,
    required this.height,
    this.type = PhotoType.normal,
    this.mediaType = MediaType.other,
    this.groupId,
    this.dHash,
    this.pHash,
    this.duration = 0,
    this.orientation = 0,
    this.isFavorite = false,
    this.title,
    this.createDateSecond,
    this.modifiedDateSecond,
    this.relativePath,
  });

  final String? dHash;
  final String? pHash;

  MediaItem copyWith({
    String? id,
    String? path,
    int? sizeBytes,
    DateTime? createDateTime,
    PhotoType? type,
    MediaType? mediaType,
    int? width,
    int? height,
    String? groupId,
    String? dHash,
    String? pHash,
    int? duration,
    int? orientation,
    bool? isFavorite,
    String? title,
    int? createDateSecond,
    int? modifiedDateSecond,
    String? relativePath,
  }) {
    return MediaItem(
      id: id ?? this.id,
      path: path ?? this.path,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      createDateTime: createDateTime ?? this.createDateTime,
      type: type ?? this.type,
      mediaType: mediaType ?? this.mediaType,
      width: width ?? this.width,
      height: height ?? this.height,
      groupId: groupId ?? this.groupId,
      dHash: dHash ?? this.dHash,
      pHash: pHash ?? this.pHash,
      duration: duration ?? this.duration,
      orientation: orientation ?? this.orientation,
      isFavorite: isFavorite ?? this.isFavorite,
      title: title ?? this.title,
      createDateSecond: createDateSecond ?? this.createDateSecond,
      modifiedDateSecond: modifiedDateSecond ?? this.modifiedDateSecond,
      relativePath: relativePath ?? this.relativePath,
    );
  }
}

extension MediaItemExtension on MediaItem {
  static MediaItem fromAssetsEntity(AssetEntity entity) {
    return MediaItem(
      id: entity.id,
      path: entity.relativePath ?? '',
      createDateTime: entity.createDateTime,
      width: entity.width,
      height: entity.height,
      mediaType: getMediaTypeFromAssetType(type: entity.type),
      duration: entity.duration,
      orientation: entity.orientation,
      isFavorite: entity.isFavorite,
      title: entity.title,
      createDateSecond: entity.createDateSecond,
      modifiedDateSecond: entity.modifiedDateSecond,
      relativePath: entity.relativePath,
    );
  }
}

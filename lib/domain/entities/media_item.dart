import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/core/enums/media_type.dart';

import '../enums/photo_type.dart';

class MediaItem {
  final String id;
  final String path;
  final DateTime createDateTime;
  final PhotoType type;
  final MediaType mediaType;
  final AssetEntity? assetEntity;
  final int width;
  final int height;
  final String? groupId;
  final int duration;
  final int? orientation;
  final bool? isFavorite;
  final String? title;
  final int? createDateSecond;
  final int? modifiedDateSecond;
  final int size;
  final String? relativePath;

  const MediaItem({
    required this.id,
    required this.path,
    required this.createDateTime,
    required this.width,
    required this.height,
    this.size = 0,
    this.type = PhotoType.normal,
    this.mediaType = MediaType.other,
    this.assetEntity,
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
    DateTime? createDateTime,
    PhotoType? type,
    MediaType? mediaType,
    AssetEntity? assetEntity,
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
    int? size,
    String? relativePath,
  }) {
    return MediaItem(
      id: id ?? this.id,
      path: path ?? this.path,
      createDateTime: createDateTime ?? this.createDateTime,
      type: type ?? this.type,
      mediaType: mediaType ?? this.mediaType,
      assetEntity: assetEntity ?? this.assetEntity,
      width: width ?? this.width,
      height: height ?? this.height,
      size: size ?? this.size,
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
      size: 0, // Size will be fetched async when needed
      mediaType: getMediaTypeFromAssetType(type: entity.type),
      assetEntity: entity,
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

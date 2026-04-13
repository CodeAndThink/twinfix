import '../enums/photo_type.dart';

class PhotoItem {
  final String id;
  final String path;
  final int sizeBytes;
  final int createDateTime;
  final PhotoType type;
  final int width;
  final int height;
  final String? checksum;

  const PhotoItem({
    required this.id,
    required this.path,
    required this.sizeBytes,
    required this.createDateTime,
    required this.width,
    required this.height,
    this.type = PhotoType.normal,
    this.checksum,
    this.dHash,
    this.pHash,
  });

  final String? dHash;
  final String? pHash;

  DateTime get createDate =>
      DateTime.fromMillisecondsSinceEpoch(createDateTime);

  PhotoItem copyWith({
    String? id,
    String? path,
    int? sizeBytes,
    int? createDateTime,
    PhotoType? type,
    int? width,
    int? height,
    String? checksum,
    String? dHash,
    String? pHash,
  }) {
    return PhotoItem(
      id: id ?? this.id,
      path: path ?? this.path,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      createDateTime: createDateTime ?? this.createDateTime,
      type: type ?? this.type,
      width: width ?? this.width,
      height: height ?? this.height,
      checksum: checksum ?? this.checksum,
      dHash: dHash ?? this.dHash,
      pHash: pHash ?? this.pHash,
    );
  }
}

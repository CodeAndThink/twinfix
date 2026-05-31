import 'package:isar_community/isar.dart';

part 'photo_item_db.g.dart';

@collection
class PhotoItemDb {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String localId;

  late String path;

  late int createDateTime;

  @enumerated
  late PhotoTypeDb type;

  late int width;
  late int height;

  late int fileSize;

  // Hashes used for deep scanning
  String? dHash;
  String? pHash;

  // Group ID assigned by the clustering algorithm
  @Index()
  String? groupId;
}

enum PhotoTypeDb {
  normal,
  duplicate,
  burst,
  blurry,
  screenshot;

  bool get isNormal => this == PhotoTypeDb.normal;
  bool get isDuplicate => this == PhotoTypeDb.duplicate;
  bool get isBurst => this == PhotoTypeDb.burst;
  bool get isBlurry => this == PhotoTypeDb.blurry;
  bool get isScreenshot => this == PhotoTypeDb.screenshot;
}

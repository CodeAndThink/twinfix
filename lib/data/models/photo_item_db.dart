import 'package:isar_community/isar.dart';

part 'photo_item_db.g.dart';

@collection
class PhotoItemDb {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String localId;

  late String path;

  @Index()
  late int sizeBytes;

  late int createDateTime;

  @enumerated
  late PhotoTypeDb type;

  late int width;
  late int height;

  // Hashes used for deep scanning
  String? dHash;
  String? pHash;
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

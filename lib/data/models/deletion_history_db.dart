import 'package:isar_community/isar.dart';

part 'deletion_history_db.g.dart';

@collection
class DeletionHistoryDb {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime timestamp;

  int totalCount = 0;
  int totalDeletedSize = 0;
  int blurryCount = 0;
  int duplicateCount = 0;
}

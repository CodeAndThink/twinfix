import 'package:isar_community/isar.dart';
import 'sync_status.dart';

part 'deletion_history_db.g.dart';

@collection
class DeletionHistoryDb {
  Id id = Isar.autoIncrement;

  @Index()
  String? remoteId; // Supabase UUID

  @Index()
  String? userId; // Supabase User UUID (null if guest)

  @Index()
  late DateTime timestamp;

  int totalCount = 0;
  int totalDeletedSize = 0;
  int blurryCount = 0;
  int duplicateCount = 0;

  @enumerated
  SyncStatus syncStatus = SyncStatus.pendingCreate;

  bool isGuest = true;
  DateTime updatedAt = DateTime.now();
}

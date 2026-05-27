import 'package:isar_community/isar.dart';
import 'sync_status.dart';

part 'user_profile_db.g.dart';

@collection
class UserProfileDb {
  Id id = Isar.autoIncrement;

  @Index()
  String? remoteId; // Supabase UUID

  int totalCleanedBytes = 0;
  int streakDays = 0;
  List<String> badgeIds = const [];
  List<DateTime?> badgeEarnedDates = const [];
  DateTime? lastCleanedAt;
  bool isPro = false;
  String? fullName;
  int avatarTypeId = 0;
  int frameTypeId = 0;

  // Achievement tracking counters
  int totalDeletedPhotos = 0;
  int blurryDeletedPhotos = 0;
  int duplicateDeletedPhotos = 0;
  int maxDeletedInOneSession = 0;
  bool hasUsedAiCleaner = false;

  @enumerated
  SyncStatus syncStatus = SyncStatus.pendingCreate;

  bool isGuest = true;
  DateTime updatedAt = DateTime.now();
}

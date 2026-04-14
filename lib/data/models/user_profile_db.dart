import 'package:isar_community/isar.dart';

part 'user_profile_db.g.dart';

@collection
class UserProfileDb {
  Id id = 0; // Single guest profile

  int totalCleanedBytes = 0;
  int streakDays = 0;
  List<String> badgeIds = const [];
  DateTime? lastCleanedAt;
  bool isPro = false;
}

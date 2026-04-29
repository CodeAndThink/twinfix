import 'package:isar_community/isar.dart';

import '../../data/models/deletion_history_db.dart';

class DeletionHistory {
  final int? id;
  final DateTime timestamp;
  final int totalCount;
  final int blurryCount;
  final int duplicateCount;

  const DeletionHistory({
    this.id,
    required this.timestamp,
    required this.totalCount,
    this.blurryCount = 0,
    this.duplicateCount = 0,
  });

  factory DeletionHistory.fromDb(DeletionHistoryDb db) {
    return DeletionHistory(
      id: db.id,
      timestamp: db.timestamp,
      totalCount: db.totalCount,
      blurryCount: db.blurryCount,
      duplicateCount: db.duplicateCount,
    );
  }

  DeletionHistoryDb toDb() {
    return DeletionHistoryDb()
      ..id = id ?? Isar.autoIncrement
      ..timestamp = timestamp
      ..totalCount = totalCount
      ..blurryCount = blurryCount
      ..duplicateCount = duplicateCount;
  }
}

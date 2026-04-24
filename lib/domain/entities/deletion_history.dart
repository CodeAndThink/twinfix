import 'package:isar_community/isar.dart';

import '../../data/models/deletion_history_db.dart';

class DeletionHistory {
  final int? id;
  final DateTime timestamp;
  final int totalCount;
  final int bytesFreed;
  final int blurryCount;
  final int duplicateCount;

  const DeletionHistory({
    this.id,
    required this.timestamp,
    required this.totalCount,
    required this.bytesFreed,
    this.blurryCount = 0,
    this.duplicateCount = 0,
  });

  factory DeletionHistory.fromDb(DeletionHistoryDb db) {
    return DeletionHistory(
      id: db.id,
      timestamp: db.timestamp,
      totalCount: db.totalCount,
      bytesFreed: db.bytesFreed,
      blurryCount: db.blurryCount,
      duplicateCount: db.duplicateCount,
    );
  }

  DeletionHistoryDb toDb() {
    return DeletionHistoryDb()
      ..id = id ?? Isar.autoIncrement
      ..timestamp = timestamp
      ..totalCount = totalCount
      ..bytesFreed = bytesFreed
      ..blurryCount = blurryCount
      ..duplicateCount = duplicateCount;
  }
}

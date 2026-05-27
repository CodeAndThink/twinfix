import 'package:isar_community/isar.dart';

import '../../data/models/deletion_history_db.dart';
import '../../data/models/sync_status.dart';

class DeletionHistory {
  final int? id;
  final DateTime timestamp;
  final int totalCount;
  final int totalDeletedSize;
  final int blurryCount;
  final int duplicateCount;

  // Offline-first sync metadata
  final int localId;
  final String? remoteId;
  final String? userId;
  final SyncStatus syncStatus;
  final bool isGuest;
  final DateTime? updatedAt;

  const DeletionHistory({
    this.id,
    required this.timestamp,
    required this.totalCount,
    this.totalDeletedSize = 0,
    this.blurryCount = 0,
    this.duplicateCount = 0,
    this.localId = 0,
    this.remoteId,
    this.userId,
    this.syncStatus = SyncStatus.pendingCreate,
    this.isGuest = true,
    this.updatedAt,
  });

  factory DeletionHistory.fromDb(DeletionHistoryDb db) {
    return DeletionHistory(
      id: db.id,
      timestamp: db.timestamp,
      totalCount: db.totalCount,
      totalDeletedSize: db.totalDeletedSize,
      blurryCount: db.blurryCount,
      duplicateCount: db.duplicateCount,
      localId: db.id,
      remoteId: db.remoteId,
      userId: db.userId,
      syncStatus: db.syncStatus,
      isGuest: db.isGuest,
      updatedAt: db.updatedAt,
    );
  }

  DeletionHistoryDb toDb() {
    return DeletionHistoryDb()
      ..id = id ?? Isar.autoIncrement
      ..timestamp = timestamp
      ..totalCount = totalCount
      ..totalDeletedSize = totalDeletedSize
      ..blurryCount = blurryCount
      ..duplicateCount = duplicateCount
      ..remoteId = remoteId
      ..userId = userId
      ..syncStatus = syncStatus
      ..isGuest = isGuest
      ..updatedAt = updatedAt ?? DateTime.now();
  }

  factory DeletionHistory.fromJson(Map<String, dynamic> json) {
    return DeletionHistory(
      remoteId: json['id']?.toString(),
      userId: json['user_id'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String).toLocal(),
      totalCount: json['total_count'] as int? ?? 0,
      totalDeletedSize: json['total_deleted_size'] as int? ?? 0,
      blurryCount: json['blurry_count'] as int? ?? 0,
      duplicateCount: json['duplicate_count'] as int? ?? 0,
      syncStatus: SyncStatus.synced,
      isGuest: false,
    );
  }

  Map<String, dynamic> toJson({required String userId}) {
    return {
      'user_id': userId,
      'timestamp': timestamp.toUtc().toIso8601String(),
      'total_count': totalCount,
      'total_deleted_size': totalDeletedSize,
      'blurry_count': blurryCount,
      'duplicate_count': duplicateCount,
    };
  }
}

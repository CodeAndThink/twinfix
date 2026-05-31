import 'package:equatable/equatable.dart';

class StorageInfo extends Equatable {
  final double totalSize; // in bytes
  final double freeSize; // in bytes
  final double usedSize; // in bytes
  final double usagePercent;

  const StorageInfo({
    required this.totalSize,
    required this.freeSize,
    required this.usedSize,
    required this.usagePercent,
  });

  @override
  List<Object?> get props => [totalSize, freeSize, usedSize, usagePercent];
}

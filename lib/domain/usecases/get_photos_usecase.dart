import 'package:injectable/injectable.dart';
import 'package:twinfix/domain/entities/media_item.dart';

import '../repositories/photo_repository.dart';

@lazySingleton
class GetPhotosUseCase {
  final PhotoRepository repository;

  GetPhotosUseCase({required this.repository});

  /// Invoke scan function to handle duplicate photo discovery logic
  Future<void> executeScanInfo({
    bool isPro = false,
    void Function(int current, int total)? onProgress,
  }) async {
    await repository.scanAndGroupPhotos(isPro: isPro, onProgress: onProgress);
  }

  /// Get the list of results after categorization is complete
  Future<List<MediaItem>> executeGetGroupedList() async {
    return await repository.getGroupedPhotos();
  }
}

import 'package:injectable/injectable.dart';

import '../entities/photo_item.dart';
import '../repositories/photo_repository.dart';

@lazySingleton
class GetPhotosUseCase {
  final PhotoRepository repository;

  GetPhotosUseCase({required this.repository});

  /// Gọi hàm scan để xử lý logic tìm ảnh trùng lặp
  Future<void> executeScanInfo({bool isPro = false}) async {
    await repository.scanAndGroupPhotos(isPro: isPro);
  }

  /// Lấy danh sách kết quả sau khi phân loại xong
  Future<List<PhotoItem>> executeGetGroupedList() async {
    return await repository.getGroupedPhotos();
  }
}

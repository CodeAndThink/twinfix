import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/enums/sort_type.dart';
import 'package:twinfix/core/repositories/user_repository.dart';
import 'package:twinfix/data/datasources/photo_local_datasource.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/gallery_manager/cubit/gallery_manager_state.dart';
import 'package:twinfix/presentation/features/gallery_manager/navigator/gallery_manager_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class GalleryManagerCubit extends BaseCubit<GalleryManagerState> {
  final GalleryManagerNavigator navigator;
  final UserRepository userRepository;
  final PhotoLocalDataSource _photoLocalDataSource;

  GalleryManagerCubit({
    required this.navigator,
    required this.userRepository,
    required PhotoLocalDataSource photoLocalDataSource,
  }) : _photoLocalDataSource = photoLocalDataSource,
       super(const GalleryManagerState());

  Future<void> init() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final assets = await _photoLocalDataSource.getGalleryAssets();
      emit(state.copyWith(assets: assets, status: LoadStatus.success));
    } catch (e) {
      emit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void removePhotoFromList(int index, {bool isDiscard = false}) {
    if (!state.status.isSuccess) return;

    final photoId = state.assets[index].id;
    final currentSelected = Set<String>.from(state.selectedPhotoIds);

    if (isDiscard) {
      currentSelected.add(photoId); // add nếu chưa có
    } else {
      currentSelected.remove(photoId); // remove nếu có
    }

    safeEmit(state.copyWith(selectedPhotoIds: currentSelected));
  }

  void changeSortType({required SortType sortType}) {
    final sortedAssets = _sortAssets(state.assets, sortType);
    safeEmit(state.copyWith(sortType: sortType, assets: sortedAssets));
  }

  List<AssetEntity> _sortAssets(List<AssetEntity> assets, SortType sortType) {
    switch (sortType) {
      case SortType.dateDesc:
        return assets.toList()
          ..sort((a, b) => b.createDateTime.compareTo(a.createDateTime));
      case SortType.dateAsc:
        return assets.toList()
          ..sort((a, b) => a.createDateTime.compareTo(b.createDateTime));
      case SortType.sizeDesc:
        return assets.toList()
          ..sort((a, b) => (b.width * b.height).compareTo(a.width * a.height));
      case SortType.sizeAsc:
        return assets.toList()
          ..sort((a, b) => (a.width * a.height).compareTo(b.width * b.height));
    }
  }

  Future<void> confirmDeletion() async {
    navigator.dialog.showConfirm(
      title: S.current.deleteSelectedPhotos(state.selectedPhotoIds.length),
      message: S.current.deleteSelectedPhotosMessage(
        state.selectedPhotoIds.length,
      ),
      confirmText: S.current.delete,
      onConfirm: deleteSelectedPhotos,
      cancelText: S.current.cancel,
    );
  }

  Future<void> deleteSelectedPhotos() async {
    if (state.selectedPhotoIds.isEmpty || state.status.isLoading) return;

    safeEmit(state.copyWith(status: LoadStatus.loading));
    try {
      // 1. Tính toán dung lượng của những ảnh được chọn ngay trước khi xóa
      int totalSaved = 0;
      final selectedAssets = state.assets
          .where((e) => state.selectedPhotoIds.contains(e.id))
          .toList();

      await Future.wait(
        selectedAssets.map((asset) async {
          try {
            final file = await asset.file;
            if (file != null) {
              totalSaved += await file.length();
            }
          } catch (_) {}
        }),
      );

      // 2. Thực hiện xóa
      final idsToDelete = state.selectedPhotoIds.toList();
      final result = await PhotoManager.editor.deleteWithIds(idsToDelete);

      if (result.isNotEmpty) {
        final temp = List<AssetEntity>.from(state.assets);
        temp.removeWhere((item) => state.selectedPhotoIds.contains(item.id));

        final updatedProfile = await userRepository.addCleanedBytes(totalSaved);

        navigator.showCleanupSuccess(
          bytesSaved: totalSaved,
          profile: updatedProfile,
        );

        safeEmit(
          state.copyWith(
            status: LoadStatus.success,
            selectedPhotoIds: {},
            assets: temp,
          ),
        );
      } else {
        safeEmit(state.copyWith(status: LoadStatus.success));
      }
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void clearSelection() {
    safeEmit(state.copyWith(selectedPhotoIds: {}));
  }
}

import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/enums/sort_type.dart';
import 'package:twinfix/core/repositories/user_repository.dart';
import 'package:twinfix/data/datasources/photo_local_datasource.dart';
import 'package:twinfix/presentation/features/confirm_delete/page/confirm_delete_page.dart';
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

  Future<void> init({required RequestType requestType}) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final assets = await _photoLocalDataSource.getGalleryAssets(
        type: requestType,
      );
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

  void removeDeletedPhotos(List<String> deletedIds) {
    if (deletedIds.isEmpty) return;

    final temp = List<AssetEntity>.from(state.assets);
    temp.removeWhere((item) => deletedIds.contains(item.id));

    final currentSelected = Set<String>.from(state.selectedPhotoIds);
    currentSelected.removeAll(deletedIds);

    safeEmit(
      state.copyWith(
        status: LoadStatus.success,
        assets: temp,
        selectedPhotoIds: currentSelected,
      ),
    );
  }

  void clearSelection() {
    safeEmit(state.copyWith(selectedPhotoIds: {}));
  }

  Future<void> confirmDelete() async {
    final selectedAssets = state.assets
        .where((e) => state.selectedPhotoIds.contains(e.id))
        .toList();

    if (selectedAssets.isEmpty) return;

    final result = await navigator.openConfirmDelete(selectedAssets);
    if (result != null && result is ConfirmDeleteResult) {
      if (result.deletedIds.isNotEmpty && result.updatedProfile != null) {
        navigator.showCleanupSuccess(
          bytesSaved: result.bytesSaved,
          profile: result.updatedProfile!,
        );
      }

      final currentSelected = Set<String>.from(state.selectedPhotoIds);
      currentSelected.removeAll(result.deletedIds);
      currentSelected.removeAll(result.unselectedIds);

      final temp = List<AssetEntity>.from(state.assets);
      temp.removeWhere((item) => result.deletedIds.contains(item.id));

      safeEmit(
        state.copyWith(
          status: LoadStatus.success,
          selectedPhotoIds: currentSelected,
          assets: temp,
        ),
      );
    }
  }
}

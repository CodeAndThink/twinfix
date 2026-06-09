import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/enums/media_type.dart';
import 'package:twinfix/core/enums/sort_type.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/domain/enums/photo_type.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/presentation/features/confirm_delete/page/confirm_delete_page.dart';
import 'package:twinfix/presentation/features/gallery_manager/cubit/gallery_manager_state.dart';
import 'package:twinfix/presentation/features/gallery_manager/navigator/gallery_manager_navigator.dart';
import 'package:twinfix/presentation/features/gallery_manager/pages/gallery_manager_page.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class GalleryManagerCubit extends BaseCubit<GalleryManagerState> {
  final GalleryManagerNavigator navigator;
  final AuthRepository authRepository;
  final PhotoRepository photoRepository;

  GalleryManagerCubit({
    required this.navigator,
    required this.authRepository,
    required this.photoRepository,
  }) : super(const GalleryManagerState());

  Future<void> init({required GalleryManagerArgs args}) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      if (args.initialAssets != null) {
        emit(
          state.copyWith(
            assets: args.initialAssets,
            status: LoadStatus.success,
          ),
        );
        return;
      }
      List<MediaItem> assets = [];
      switch (args.photoType) {
        case PhotoType.livePhoto:
          assets = await photoRepository.getLivePhotos();
          break;
        case PhotoType.screenshot:
          assets = await photoRepository.getScreenshots();
          break;
        case PhotoType.blurry:
          assets = await photoRepository.getBlurryPhotos();
          break;
        default:
          assets = await photoRepository.getGalleryAssets(
            type: args.mediaType.requestType,
          );
          break;
      }

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
      currentSelected.add(photoId);
    } else {
      currentSelected.remove(photoId);
    }

    safeEmit(state.copyWith(selectedPhotoIds: currentSelected));
  }

  void changeSortType({required SortType sortType}) {
    final sortedAssets = _sortAssets(state.assets, sortType);
    safeEmit(state.copyWith(sortType: sortType, assets: sortedAssets));
  }

  List<MediaItem> _sortAssets(List<MediaItem> assets, SortType sortType) {
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
      default:
        return assets;
    }
  }

  void removeDeletedPhotos(List<String> deletedIds) {
    if (deletedIds.isEmpty) return;

    final temp = List<MediaItem>.from(state.assets);
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
    final selectedItems = state.assets
        .where((e) => state.selectedPhotoIds.contains(e.id))
        .toList();

    if (selectedItems.isEmpty) return;

    final result = await navigator.openConfirmDelete(selectedItems);
    if (result != null && result is ConfirmDeleteResult) {
      if (result.deletedIds.isNotEmpty && result.updatedProfile != null) {
        await navigator.showCleanupSuccess(
          mediaNum: result.deletedIds.length,
          profile: result.updatedProfile!,
          totalSizeDeleted: result.totalSizeDeleted,
        );
        if (result.newBadgeIds.isNotEmpty) {
          await navigator.dialog.showNewBadgesDialog(result.newBadgeIds);
        }
      }

      final currentSelected = Set<String>.from(state.selectedPhotoIds);
      currentSelected.removeAll(result.deletedIds);
      currentSelected.removeAll(result.unselectedIds);

      final temp = List<MediaItem>.from(state.assets);
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

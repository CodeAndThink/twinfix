import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/data/datasources/photo_local_datasource.dart';
import 'package:twinfix/presentation/features/gallery_manager/cubit/gallery_manager_state.dart';
import 'package:twinfix/presentation/features/gallery_manager/navigator/gallery_manager_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class GalleryManagerCubit extends BaseCubit<GalleryManagerState> {
  final GalleryManagerNavigator navigator;
  final PhotoLocalDataSource _photoLocalDataSource;

  GalleryManagerCubit({
    required this.navigator,
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
    if (state.status.isSuccess) {
      if (isDiscard) {
        final photo = state.assets[index];
        togglePhotoSelection(photo.id);
      }
    }
  }

  void togglePhotoSelection(String id) {
    final currentSelected = Set<String>.from(state.selectedPhotoIds);
    if (currentSelected.contains(id)) {
      currentSelected.remove(id);
    } else {
      currentSelected.add(id);
    }
    safeEmit(state.copyWith(selectedPhotoIds: currentSelected));
  }
}

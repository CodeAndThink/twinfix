import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'remove_gps_state.dart';
import '../navigator/remove_gps_navigator.dart';

class RemoveGPSCubit extends BaseCubit<RemoveGPSState> {
  final PhotoRepository _photoRepository;
  final RemoveGPSNavigator navigator;

  RemoveGPSCubit(this._photoRepository, this.navigator)
    : super(const RemoveGPSState());

  Future<void> startScan() async {
    if (state.status.isLoading) return;
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final photos = await _photoRepository.getPhotosWithGPS();
      emit(state.copyWith(status: LoadStatus.success, photos: photos));
    } catch (e) {
      emit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void toggleSelection({required String id}) {
    final selectedIds = List<String>.from(state.selectedIds);
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    emit(state.copyWith(selectedIds: selectedIds));
  }

  void clearSelection() {
    emit(state.copyWith(selectedIds: []));
  }

  Future<void> removeGPS() async {
    if (state.selectedIds.isEmpty) return;
    if (state.status.isLoading) return;

    emit(state.copyWith(status: LoadStatus.loading));
    try {
      await _photoRepository.removeGPS(state.selectedIds);

      // Since we are creating copies, the original images still have GPS.
      // But we might want to refresh the list or show a success message.
      // For now, let's just clear selection and show success.
      emit(state.copyWith(status: LoadStatus.success, selectedIds: []));

      // Optionally re-scan or just notify user
    } catch (e) {
      emit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}

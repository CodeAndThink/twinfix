import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/presentation/features/blur_detection/cubit/blur_detection_state.dart';
import 'package:twinfix/presentation/features/blur_detection/navigator/blur_detection_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class BlurDetectionCubit extends BaseCubit<BlurDetectionState> {
  final BlurDetectionNavigator navigator;
  final PhotoRepository photoRepository;

  BlurDetectionCubit({required this.navigator, required this.photoRepository})
    : super(const BlurDetectionState());

  Future<void> scan() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final blurryAssets = await photoRepository.getBlurryPhotos(
        onProgress: (current, total) {
          safeEmit(state.copyWith(scanProgress: current, scanTotal: total));
        },
      );

      emit(
        state.copyWith(status: LoadStatus.success, blurryAssets: blurryAssets),
      );
    } catch (e) {
      emit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void onShowResults() {
    navigator.pushGalleryManagerResults(state.blurryAssets);
  }
}

import 'package:twinfix/core/enums/feature_type.dart';
import 'package:twinfix/domain/enums/photo_type.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/presentation/features/other_feature/cubit/other_feature_state.dart';
import 'package:twinfix/presentation/features/other_feature/navigator/other_feature_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class OtherFeatureCubit extends BaseCubit<OtherFeatureState> {
  final OtherFeatureNavigator navigator;
  final PhotoRepository photoRepository;

  OtherFeatureCubit({required this.navigator, required this.photoRepository})
    : super(OtherFeatureState());

  Future<void> onFeatureTap(FeatureType featureType) async {
    emit(state.copyWith(status: BaseStatus.loading));
    try {
      final allPhotos = await photoRepository.getGroupedPhotos();
      List<PhotoItem> filtered;

      switch (featureType) {
        case FeatureType.duplicatePhoto:
          filtered = allPhotos
              .where((p) => p.type == PhotoType.duplicate)
              .toList();
          navigator.navigateToDuplicatePhotos(filtered);
          break;
        case FeatureType.blurryPhoto:
          filtered = allPhotos
              .where((p) => p.type == PhotoType.blurry)
              .toList();
          navigator.navigateToBlurryPhotos(filtered);
          break;
      }
      emit(state.copyWith(status: BaseStatus.success));
    } catch (e) {
      emit(state.copyWith(status: BaseStatus.error));
    }
  }
}

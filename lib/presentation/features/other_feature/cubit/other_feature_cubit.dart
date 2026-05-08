import 'dart:io';
import 'package:twinfix/core/enums/media_type.dart';
import 'package:twinfix/core/services/permission_service.dart';
import 'package:twinfix/core/utils/app_utils.dart';
import 'package:twinfix/domain/enums/photo_type.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/gallery_manager/pages/gallery_manager_page.dart';
import 'package:twinfix/presentation/features/image_editor/page/image_editor_page.dart';
import 'package:twinfix/presentation/features/other_feature/cubit/other_feature_state.dart';
import 'package:twinfix/presentation/features/other_feature/navigator/other_feature_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'package:twinfix/domain/enums/other_feature.dart';
import 'package:twinfix/presentation/features/watermark/page/watermark_page.dart';
import 'package:twinfix/presentation/features/face_blur/page/face_blur_page.dart';

class OtherFeatureCubit extends BaseCubit<OtherFeatureState> {
  final OtherFeatureNavigator navigator;
  final PhotoRepository photoRepository;
  final PermissionService permissionService;

  OtherFeatureCubit({
    required this.navigator,
    required this.photoRepository,
    required this.permissionService,
  }) : super(OtherFeatureState());

  final List<PhotoType> items = [if (Platform.isIOS) PhotoType.livePhoto];

  Future<void> onFeatureTap({
    required PhotoType photoType,
    required MediaType mediaType,
  }) async {
    navigator.pushGalleryManager(
      args: GalleryManagerArgs(mediaType: mediaType, photoType: photoType),
    );
  }

  Future<void> onOtherFeatureTap(OtherFeature type) async {
    switch (type) {
      case OtherFeature.addWaterMark:
        final image = await AppUtils.pickImage();
        if (image != null) {
          navigator.pushWatermark(args: WatermarkPageArgs(image: image));
        }
        break;
      case OtherFeature.blurFace:
        final image = await AppUtils.pickImage();
        if (image != null) {
          navigator.pushFaceBlur(args: FaceBlurPageArgs(image: image));
        }
        break;
      case OtherFeature.edit:
        final image = await AppUtils.pickImage();
        if (image != null) {
          navigator.pushImageEditor(args: ImageEditorPageArgs(image: image));
        }
        break;
      case OtherFeature.document:
        navigator.pushDocumentDetection();
        break;
      case OtherFeature.removeGPS:
        navigator.pushRemoveGPS();
        break;
      case OtherFeature.blurDetection:
        navigator.pushBlurDetection();
        break;
    }
  }
}

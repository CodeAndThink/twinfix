import 'package:twinfix/core/enums/media_type.dart';
import 'package:twinfix/domain/enums/photo_type.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/presentation/features/gallery_manager/pages/gallery_manager_page.dart';
import 'package:twinfix/presentation/features/image_editor/page/image_editor_page.dart';
import 'package:twinfix/presentation/features/other_feature/cubit/other_feature_state.dart';
import 'package:twinfix/presentation/features/other_feature/navigator/other_feature_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twinfix/domain/enums/other_feature.dart';
import 'package:twinfix/presentation/features/watermark/page/watermark_page.dart';
import 'package:twinfix/presentation/features/face_blur/page/face_blur_page.dart';

class OtherFeatureCubit extends BaseCubit<OtherFeatureState> {
  final OtherFeatureNavigator navigator;
  final PhotoRepository photoRepository;

  OtherFeatureCubit({required this.navigator, required this.photoRepository})
      : super(OtherFeatureState());

  final List<PhotoType> items = [
    PhotoType.livePhoto,
    PhotoType.blurry,
    PhotoType.screenshot,
  ];

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
        final picker = ImagePicker();
        final image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          navigator.pushWatermark(args: WatermarkPageArgs(image: image));
        }
        break;
      case OtherFeature.blurFace:
        final picker = ImagePicker();
        final image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          navigator.pushFaceBlur(args: FaceBlurPageArgs(image: image));
        }
        break;
      case OtherFeature.edit:
        final picker = ImagePicker();
        final image = await picker.pickImage(source: ImageSource.gallery);
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
    }
  }
}

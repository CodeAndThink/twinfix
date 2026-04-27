import 'package:twinfix/core/enums/media_type.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';
import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/domain/enums/photo_type.dart';
import 'package:twinfix/presentation/features/gallery_manager/pages/gallery_manager_page.dart';

class BlurDetectionNavigator extends BaseNavigator {
  BlurDetectionNavigator(super.context);

  void pushGalleryManagerResults(List<MediaItem> results) {
    replaceNamed(
      AppRouter.galleryManager,
      extra: GalleryManagerArgs(
        photoType: PhotoType.blurry,
        mediaType: MediaType.image,
        initialAssets: results,
      ),
    );
  }
}

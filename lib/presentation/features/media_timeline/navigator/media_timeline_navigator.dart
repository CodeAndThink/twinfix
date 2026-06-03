import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/presentation/features/gallery_manager/pages/gallery_manager_page.dart';
import 'package:twinfix/core/enums/media_type.dart';

class MediaTimelineNavigator extends BaseNavigator {
  const MediaTimelineNavigator(super.context);

  void navigateToGalleryManager(List<MediaItem> items) {
    pushNamed(
      AppRouter.galleryManager,
      extra: GalleryManagerArgs(
        mediaType: MediaType.image,
        initialAssets: items,
      ),
    );
  }
}

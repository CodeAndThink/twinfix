import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';
import 'package:twinfix/presentation/features/gallery_manager/pages/gallery_manager_page.dart';

class MediaTypeSelectionNavigator extends BaseNavigator {
  MediaTypeSelectionNavigator(super.context);

  void pushGalleryManager({required GalleryManagerArgs args}) {
    pushNamed(AppRouter.galleryManager, extra: args);
  }
}

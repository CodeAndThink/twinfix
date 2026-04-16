import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/presentation/features/confirm_delete/page/confirm_delete_page.dart';
import 'package:twinfix/presentation/features/media_viewer/pages/media_viewer_page.dart';

class GalleryManagerNavigator extends BaseNavigator {
  GalleryManagerNavigator(super.context);

  Future<dynamic> openConfirmDelete(List<MediaItem> itemsToDelete) async {
    return await pushNamed(
      AppRouter.confirmDelete,
      extra: ConfirmDeletePageArgs(itemsToDelete: itemsToDelete),
    );
  }

  void navigateToMediaViewer(MediaItem photo) {
    pushNamed(AppRouter.mediaViewer, extra: MediaViewerArgs(asset: photo));
  }
}

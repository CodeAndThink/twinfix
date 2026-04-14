import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';
import 'package:twinfix/presentation/features/confirm_delete/page/confirm_delete_page.dart';
import 'package:twinfix/presentation/features/media_viewer/pages/media_viewer_page.dart';

class GalleryManagerNavigator extends BaseNavigator {
  GalleryManagerNavigator(super.context);

  Future<dynamic> openConfirmDelete(List<dynamic> itemsToDelete) async {
    return await pushNamed(
      AppRouter.confirmDelete,
      extra: ConfirmDeletePageArgs(itemsToDelete: itemsToDelete),
    );
  }

  void navigateToMediaViewer(AssetEntity asset) {
    pushNamed(AppRouter.mediaViewer, extra: MediaViewerArgs(asset: asset));
  }
}

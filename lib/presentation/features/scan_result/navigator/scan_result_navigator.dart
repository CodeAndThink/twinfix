import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/core/navigation/base_navigator.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/presentation/features/confirm_delete/page/confirm_delete_page.dart';

class ScanResultNavigator extends BaseNavigator {
  ScanResultNavigator(super.context);

  Future<dynamic> navigateToConfirmDelete({
    required List<MediaItem> itemsToDelete,
  }) async {
    return await pushNamed(
      AppRouter.confirmDelete,
      extra: ConfirmDeletePageArgs(itemsToDelete: itemsToDelete),
    );
  }
}

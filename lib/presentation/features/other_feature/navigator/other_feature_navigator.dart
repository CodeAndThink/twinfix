import 'package:twinfix/core/navigation/base_navigator.dart';

import 'package:twinfix/core/navigation/app_router.dart';
import 'package:twinfix/presentation/features/gallery_manager/pages/gallery_manager_page.dart';
import 'package:twinfix/presentation/features/watermark/page/watermark_page.dart';
import 'package:twinfix/presentation/features/image_editor/page/image_editor_page.dart';

class OtherFeatureNavigator extends BaseNavigator {
  OtherFeatureNavigator(super.context);

  void pushGalleryManager({required GalleryManagerArgs args}) {
    pushNamed(AppRouter.galleryManager, extra: args);
  }

  void pushWatermark({required WatermarkPageArgs args}) {
    pushNamed(AppRouter.watermark, extra: args);
  }

  void pushImageEditor({required ImageEditorPageArgs args}) {
    pushNamed(AppRouter.imageEditor, extra: args);
  }
}

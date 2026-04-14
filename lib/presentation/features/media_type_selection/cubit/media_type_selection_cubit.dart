import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/enums/media_type.dart';
import 'package:twinfix/presentation/features/gallery_manager/pages/gallery_manager_page.dart';
import 'package:twinfix/presentation/features/media_type_selection/cubit/media_type_selection_state.dart';
import 'package:twinfix/presentation/features/media_type_selection/navigator/media_type_selection_navigator.dart';

class MediaTypeSelectionCubit extends Cubit<MediaTypeSelectionState> {
  final MediaTypeSelectionNavigator navigator;
  MediaTypeSelectionCubit({required this.navigator})
    : super(MediaTypeSelectionState.initial());

  void handleItemTap({required MediaType mediaType}) {
    switch (mediaType) {
      case MediaType.photo:
        navigator.pushGalleryManager(
          args: GalleryManagerArgs(mediaType: mediaType),
        );
        break;
      case MediaType.video:
        navigator.pushGalleryManager(
          args: GalleryManagerArgs(mediaType: mediaType),
        );
        break;
      case MediaType.audio:
        navigator.pushGalleryManager(
          args: GalleryManagerArgs(mediaType: mediaType),
        );
        break;
      case MediaType.other:
        navigator.pushGalleryManager(
          args: GalleryManagerArgs(mediaType: mediaType),
        );
        break;
    }
  }
}

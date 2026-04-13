import 'package:twinfix/presentation/features/gallery_manager/cubit/gallery_manager_state.dart';
import 'package:twinfix/presentation/features/gallery_manager/navigator/gallery_manager_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class GalleryManagerCubit extends BaseCubit<GalleryManagerState> {
  final GalleryManagerNavigator navigator;

  GalleryManagerCubit({required this.navigator})
    : super(const GalleryManagerState());
}

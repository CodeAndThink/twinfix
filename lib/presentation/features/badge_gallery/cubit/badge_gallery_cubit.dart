import 'package:twinfix/presentation/features/badge_gallery/cubit/badge_gallery_state.dart';
import 'package:twinfix/presentation/features/badge_gallery/navigator/badge_gallery_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class BadgeGalleryCubit extends BaseCubit<BadgeGalleryState> {
  final BadgeGalleryNavigator navigator;

  BadgeGalleryCubit({required this.navigator})
    : super(const BadgeGalleryState());
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:twinfix/core/constants/app_sizes.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/gallery_manager/cubit/gallery_manager_cubit.dart';
import 'package:twinfix/presentation/features/gallery_manager/navigator/gallery_manager_navigator.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

class GalleryManagerPage extends StatelessWidget {
  const GalleryManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          GalleryManagerCubit(navigator: GalleryManagerNavigator(context)),
      child: const GalleryManagerChildPage(),
    );
  }
}

class GalleryManagerChildPage extends StatefulWidget {
  const GalleryManagerChildPage({super.key});

  @override
  State<GalleryManagerChildPage> createState() =>
      _GalleryManagerChildPageState();
}

class _GalleryManagerChildPageState extends State<GalleryManagerChildPage> {
  late final GalleryManagerCubit _cubit;
  late ThemeData _theme;
  late S _l10n;

  @override
  void initState() {
    super.initState();

    _cubit = context.read<GalleryManagerCubit>();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _l10n = S.of(context);

    return AppScaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return Column(
      children: [
        Padding(
          padding: AppSizes.s16.paddingHorizontal,
          child: Text(
            _l10n.detectedDuplicates(items.length),
            style: _theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        if (items.isEmpty)
          _buildEmptyUI()
        else
          Expanded(
            child: CardSwiper(
              controller: _swiperController,
              cardsCount: items.length,
              numberOfCardsDisplayed: items.length,
              onSwipe: (previousIndex, currentIndex, direction) {
                Haptics.vibrate(HapticsType.light);
                bool isDiscard = direction == CardSwiperDirection.left;
                _cubit.removePhotoFromList(previousIndex, isDiscard: isDiscard);
                return true;
              },
              cardBuilder:
                  (context, index, percentThresholdX, percentThresholdY) {
                    final photo = items[index];
                    final isSelected = state.selectedPhotoIds.contains(
                      photo.id,
                    );
                    return ImageCard(photo: photo, isSelected: isSelected);
                  },
            ),
          ),
        AppSizes.s24.height,
        if (items.isNotEmpty)
          if (state.selectedPhotoIds.isNotEmpty)
            Padding(
              padding: AppSizes.s16.paddingAll,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _theme.colorScheme.error,
                  foregroundColor: _theme.colorScheme.onError,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () => _showConfirmationDialog(),
                child: Text(
                  _l10n.deleteSelected(state.selectedPhotoIds.length),
                ),
              ),
            )
          else
            Text(
              _l10n.swipeLeftToDeleteKeepRight,
              style: _theme.textTheme.bodySmall,
            ),
        AppSizes.s32.height,
      ],
    );
  }
}

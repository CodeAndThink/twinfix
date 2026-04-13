import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:twinfix/core/constants/app_sizes.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/gallery_manager/cubit/gallery_manager_cubit.dart';
import 'package:twinfix/presentation/features/gallery_manager/cubit/gallery_manager_state.dart';
import 'package:twinfix/presentation/features/gallery_manager/navigator/gallery_manager_navigator.dart';
import 'package:twinfix/presentation/features/gallery_manager/widgets/image_card.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

class GalleryManagerPage extends StatelessWidget {
  const GalleryManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GalleryManagerCubit(
        navigator: GalleryManagerNavigator(context),
        photoLocalDataSource: locator(),
      )..init(),
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
  final CardSwiperController _swiperController = CardSwiperController();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<GalleryManagerCubit>();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _l10n = S.of(context);

    return AppScaffold(title: _l10n.galleryManager, body: _buildBody());
  }

  Widget _buildBody() {
    return BlocBuilder<GalleryManagerCubit, GalleryManagerState>(
      builder: (context, state) {
        final items = state.assets;
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return Center(
            child: Text(
              _l10n.error(state.errorMessage!),
              style: TextStyle(color: _theme.colorScheme.error),
            ),
          );
        }

        if (items.isEmpty) {
          return _buildEmptyUI();
        }
        return Column(
          children: [
            Expanded(
              child: CardSwiper(
                controller: _swiperController,
                cardsCount: items.length,
                numberOfCardsDisplayed: items.length,
                onSwipe: (previousIndex, currentIndex, direction) {
                  Haptics.vibrate(HapticsType.light);
                  bool isDiscard = direction == CardSwiperDirection.left;
                  _cubit.removePhotoFromList(
                    previousIndex,
                    isDiscard: isDiscard,
                  );
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
          ],
        );
      },
    );
  }

  Widget _buildEmptyUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _l10n.perfect,
            style: _theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: _theme.colorScheme.primary,
            ),
          ),
          AppSizes.s8.height,
          Text(_l10n.deviceIsClean),
          AppSizes.s32.height,
          ElevatedButton(
            onPressed: () => _cubit.navigator.safePop(),
            child: Text(_l10n.back),
          ),
        ],
      ),
    );
  }
}

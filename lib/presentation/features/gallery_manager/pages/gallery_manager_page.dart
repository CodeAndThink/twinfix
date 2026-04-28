import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/enums/media_type.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/enums/photo_type.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/gallery_manager/cubit/gallery_manager_cubit.dart';
import 'package:twinfix/presentation/features/gallery_manager/cubit/gallery_manager_state.dart';
import 'package:twinfix/presentation/features/gallery_manager/navigator/gallery_manager_navigator.dart';
import 'package:twinfix/presentation/features/gallery_manager/pages/gallery_manager_loading_page.dart';
import 'package:twinfix/presentation/features/gallery_manager/widgets/gallery_manager_list_item.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/domain/entities/media_item.dart';

class GalleryManagerArgs {
  final MediaType mediaType;
  final PhotoType photoType;
  final List<MediaItem>? initialAssets;

  const GalleryManagerArgs({
    required this.mediaType,
    this.photoType = PhotoType.normal,
    this.initialAssets,
  });
}

class GalleryManagerPage extends StatelessWidget {
  final GalleryManagerArgs args;
  const GalleryManagerPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GalleryManagerCubit(
        userRepository: locator(),
        navigator: GalleryManagerNavigator(context),
        photoRepository: locator(),
      ),
      child: GalleryManagerChildPage(args: args),
    );
  }
}

class GalleryManagerChildPage extends StatefulWidget {
  final GalleryManagerArgs args;
  const GalleryManagerChildPage({super.key, required this.args});

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
    _cubit.init(args: widget.args);
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _l10n = S.of(context);

    return AppScaffold(
      title: _l10n.galleryManager,
      isLoading:
          _cubit.state.status.isLoading && _cubit.state.assets.isNotEmpty,
      loadingMessage: _l10n.calculatingProgress,
      actions: [
        IconButton(
          icon: Icon(Icons.sort_rounded),
          onPressed: () {
            _cubit.navigator.showSortOptionsSheet(
              selectedValue: _cubit.state.sortType,
              onSelected: (sortType) =>
                  _cubit.changeSortType(sortType: sortType),
            );
          },
        ),
      ],
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: BlocBuilder<GalleryManagerCubit, GalleryManagerState>(
        buildWhen: (previous, current) =>
            previous.status != current.status ||
            previous.sortType != current.sortType ||
            previous.assets != current.assets ||
            previous.selectedPhotoIds != current.selectedPhotoIds ||
            previous.assetSizes != current.assetSizes,
        builder: (context, state) {
          final items = state.assets;

          // Nếu là lần đầu load (chưa có data) thì hiện shimmer
          if (state.status.isLoading && items.isEmpty) {
            return const GalleryManagerLoadingPage();
          }

          if (state.errorMessage != null) {
            return Center(
              child: Text(
                _l10n.error(state.errorMessage!),
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          if (items.isEmpty && state.status.isSuccess) {
            return _buildEmptyUI();
          }

          return Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: 12.paddingHorizontal.copyWith(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 4,
                          children: [
                            Icon(Icons.undo_rounded, color: Colors.red),
                            Text(
                              _l10n.onboardingDemoSwipeLeft,
                              style: _theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 4,
                          children: [
                            Text(
                              _l10n.onboardingDemoSwipeRight,
                              style: _theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.green,
                              ),
                            ),
                            Icon(Icons.redo_rounded, color: Colors.green),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (items.isNotEmpty)
                    Expanded(
                      child: Stack(
                        children: [
                          CardSwiper(
                            padding: 12.paddingAll,
                            key: ValueKey(
                              'swiper_${items.length}_${items.firstOrNull?.id}',
                            ),
                            controller: _swiperController,
                            cardsCount: items.length,
                            numberOfCardsDisplayed: items.length > 3
                                ? 3
                                : items.length,
                            onSwipe: (previousIndex, currentIndex, direction) {
                              Haptics.vibrate(HapticsType.light);
                              bool isLeft =
                                  direction == CardSwiperDirection.left;
                              bool isRight =
                                  direction == CardSwiperDirection.right;
                              if (isLeft) {
                                _cubit.removePhotoFromList(
                                  previousIndex,
                                  isDiscard: true,
                                );
                              } else if (isRight) {
                                _cubit.removePhotoFromList(
                                  previousIndex,
                                  isDiscard: false,
                                );
                              }
                              return true;
                            },
                            cardBuilder:
                                (
                                  context,
                                  index,
                                  percentThresholdX,
                                  percentThresholdY,
                                ) {
                                  if (index >= items.length) {
                                    return const SizedBox();
                                  }
                                  final photo = items[index];
                                  final isSelected = state.selectedPhotoIds
                                      .contains(photo.id);
                                  return GestureDetector(
                                    onTap: () {
                                      _cubit.navigator.navigateToMediaViewer(
                                        photo,
                                      );
                                    },
                                    child: GalleryManagerListItem(
                                      photo: photo,
                                      isSelected: isSelected,
                                    ),
                                  );
                                },
                          ),
                        ],
                      ),
                    ),
                  8.height,
                  _buildConfirmDeleteButton(),
                ],
              ),
            ],
          );
        },
      ),
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
          8.height,
          Text(_l10n.deviceIsClean),
          32.height,
          ElevatedButton(
            onPressed: () => _cubit.navigator.safePop(),
            child: Text(_l10n.back),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmDeleteButton() {
    return BlocBuilder<GalleryManagerCubit, GalleryManagerState>(
      buildWhen: (previous, current) =>
          previous.selectedPhotoIds != current.selectedPhotoIds,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: 12.paddingHorizontal,
            child: AppFilledButton(
              enabled: state.selectedPhotoIds.isNotEmpty,
              backgroundColor: Colors.red,
              text: _l10n.deleteSelected(state.selectedPhotoIds.length),
              onPressed: () => _cubit.confirmDelete(),
            ),
          ),
        );
      },
    );
  }
}

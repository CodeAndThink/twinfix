import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:twinfix/core/constants/app_sizes.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/enums/sort_type.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/gallery_manager/cubit/gallery_manager_cubit.dart';
import 'package:twinfix/presentation/features/gallery_manager/cubit/gallery_manager_state.dart';
import 'package:twinfix/presentation/features/gallery_manager/navigator/gallery_manager_navigator.dart';
import 'package:twinfix/presentation/features/gallery_manager/widgets/image_card.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

class GalleryManagerPage extends StatelessWidget {
  const GalleryManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GalleryManagerCubit(
        userRepository: locator(),
        navigator: GalleryManagerNavigator(context),
        photoLocalDataSource: locator(),
      ),
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
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _l10n = S.of(context);

    return AppScaffold(
      title: _l10n.galleryManager,
      actions: [
        IconButton(
          icon: Icon(Icons.sort_rounded),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              showDragHandle: true,
              builder: (context) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: SortType.values.map((sortType) {
                      return InkWell(
                        onTap: () {
                          _cubit.changeSortType(sortType: sortType);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: AppSizes.s12.paddingAll,
                          child: Row(
                            children: [
                              Icon(sortType.icon),
                              AppSizes.s8.width,
                              Text(sortType.label),
                              Spacer(),
                              if (_cubit.state.sortType == sortType)
                                Icon(Icons.check_rounded),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            );
          },
        ),
      ],
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<GalleryManagerCubit, GalleryManagerState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.sortType != current.sortType ||
          previous.assets != current.assets ||
          previous.selectedPhotoIds != current.selectedPhotoIds ||
          previous.assetSizes != current.assetSizes,
      builder: (context, state) {
        final items = state.assets;

        // Nếu là lần đầu load (chưa có data) thì hiện loading giữa màn hình
        if (state.status.isLoading && items.isEmpty) {
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

        if (items.isEmpty && state.status.isSuccess) {
          return _buildEmptyUI();
        }

        return Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: AppSizes.s8.paddingHorizontal,
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
                if (items.length > 1)
                  Expanded(
                    child: CardSwiper(
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
                        bool isDiscard = direction == CardSwiperDirection.left;
                        _cubit.removePhotoFromList(
                          previousIndex,
                          isDiscard: isDiscard,
                        );
                        return true;
                      },
                      cardBuilder:
                          (
                            context,
                            index,
                            percentThresholdX,
                            percentThresholdY,
                          ) {
                            if (index >= items.length) return const SizedBox();
                            final photo = items[index];
                            final isSelected = state.selectedPhotoIds.contains(
                              photo.id,
                            );
                            return ImageCard(
                              photo: photo,
                              isSelected: isSelected,
                            );
                          },
                    ),
                  ),
                if (items.length == 1)
                  Expanded(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 0.7,
                        child: ImageCard(photo: items.first, isSelected: false),
                      ),
                    ),
                  ),
                _buildConfirmDeleteButton(),
              ],
            ),
            // Loading Overlay khi đang xử lý (ví dụ: đang xóa)
            if (state.status.isLoading)
              Container(
                color: Colors.black.withValues(alpha: 0.4),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(color: Colors.white),
                      AppSizes.s16.height,
                      Text(
                        _l10n.calculatingProgress,
                        style: _theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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

  Widget _buildConfirmDeleteButton() {
    return BlocBuilder<GalleryManagerCubit, GalleryManagerState>(
      buildWhen: (previous, current) =>
          previous.selectedPhotoIds != current.selectedPhotoIds,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: AppSizes.s16.paddingHorizontal,
            child: AppFilledButton(
              enabled: state.selectedPhotoIds.isNotEmpty,
              text: _l10n.delete,
              onPressed: () {
                _cubit.confirmDeletion();
              },
            ),
          ),
        );
      },
    );
  }
}

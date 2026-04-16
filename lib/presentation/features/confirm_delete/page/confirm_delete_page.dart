import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/confirm_delete/cubit/confirm_delete_cubit.dart';
import 'package:twinfix/presentation/features/confirm_delete/cubit/confirm_delete_state.dart';
import 'package:twinfix/presentation/features/confirm_delete/navigator/confirm_delete_navigator.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';
import 'package:twinfix/presentation/widgets/images/app_file_image.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/scaffold/custom_app_bar.dart';

import 'package:twinfix/domain/entities/media_item.dart';

class ConfirmDeletePageArgs {
  final List<MediaItem> itemsToDelete;

  const ConfirmDeletePageArgs({required this.itemsToDelete});
}

class ConfirmDeleteResult {
  final List<String> deletedIds;
  final List<String> unselectedIds;
  final int bytesSaved;
  final UserProfile? updatedProfile;
  final List<String> newBadgeIds;

  const ConfirmDeleteResult({
    required this.deletedIds,
    this.unselectedIds = const [],
    this.bytesSaved = 0,
    this.updatedProfile,
    this.newBadgeIds = const [],
  });
}

class ConfirmDeletePage extends StatelessWidget {
  final ConfirmDeletePageArgs args;

  const ConfirmDeletePage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfirmDeleteCubit(
        navigator: ConfirmDeleteNavigator(context),
        userRepository: locator(),
      )..init(args.itemsToDelete),
      child: const ConfirmDeleteChildPage(),
    );
  }
}

class ConfirmDeleteChildPage extends StatefulWidget {
  const ConfirmDeleteChildPage({super.key});

  @override
  State<ConfirmDeleteChildPage> createState() => _ConfirmDeleteChildPageState();
}

class _ConfirmDeleteChildPageState extends State<ConfirmDeleteChildPage> {
  late ConfirmDeleteCubit _cubit;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ConfirmDeleteCubit>();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return BlocBuilder<ConfirmDeleteCubit, ConfirmDeleteState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, dynamic rawResult) {
            if (didPop) return;

            // Allow manual return of proper result if user swipes back or taps app bar back button
            if (rawResult is! ConfirmDeleteResult) {
              _cubit.navigator.safePop(_cubit.createCancelResult());
            }
          },
          child: AppScaffold(
            title: S.current.confirmDelete,
            appBar: CustomAppBar(
              title: S.current.confirmDelete,
              onLeadingPressed: () {
                _cubit.navigator.safePop(_cubit.createCancelResult());
              },
            ),
            isLoading: state.status.isLoading,
            body: SafeArea(child: _buildBody(state)),
          ),
        );
      },
    );
  }

  Widget _buildBody(ConfirmDeleteState state) {
    if (state.itemsToDelete.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 64,
              color: Colors.green,
            ),
            16.height,
            Text(
              _l10n.confirmnoMorePhotosToDelete,
              style: _theme.textTheme.titleMedium,
            ),
            24.height,
            AppFilledButton(
              onPressed: () => _cubit.navigator.safePop(<String>[]),
              text: _l10n.back,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        _buildMascotHeader(),
        Expanded(
          child: GridView.builder(
            padding: 16.paddingAll,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: state.itemsToDelete.length,
            itemBuilder: (context, index) {
              final item = state.itemsToDelete[index];

              return Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: 12.borderRadius,
                    child: item.path.isNotEmpty
                        ? AppFileImage(path: item.path, fit: BoxFit.cover)
                        : item.assetEntity != null
                        ? AssetEntityImage(
                            item.assetEntity!,
                            thumbnailSize: ThumbnailSize.square(300),
                            isOriginal: false,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox.shrink(),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => _cubit.removePhoto(item.id),
                      child: Container(
                        padding: 4.paddingAll,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SizedBox(
              width: double.infinity,
              child: AppFilledButton(
                onPressed: () => _cubit.confirmDeletion(),
                backgroundColor: _theme.colorScheme.error,
                text: S.of(context).deleteSelected(state.itemsToDelete.length),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMascotHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AppAssetImage(path: AppAssets.icCrocodile0, height: 100),
          12.width,
          Expanded(
            child: Container(
              margin: 10.paddingBottom,
              padding: 12.padding,
              decoration: BoxDecoration(
                color: _theme.colorScheme.errorContainer.withValues(alpha: 0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border.all(color: _theme.colorScheme.error, width: 3),
              ),
              child: Text(
                S.of(context).delete_confirm_message,
                style: _theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: _theme.colorScheme.error,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

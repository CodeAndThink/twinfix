import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/app/cubit/subscription_cubit.dart';
import 'package:twinfix/presentation/features/confirm_delete/cubit/confirm_delete_cubit.dart';
import 'package:twinfix/presentation/features/confirm_delete/cubit/confirm_delete_state.dart';
import 'package:twinfix/presentation/features/confirm_delete/navigator/confirm_delete_navigator.dart';
import 'package:twinfix/presentation/features/confirm_delete/widgets/confirm_delete_list_item.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/scaffold/custom_app_bar.dart';

import 'package:responsive_framework/responsive_framework.dart';
import 'package:twinfix/domain/entities/media_item.dart';

class ConfirmDeletePageArgs {
  final List<MediaItem> itemsToDelete;

  const ConfirmDeletePageArgs({required this.itemsToDelete});
}

class ConfirmDeleteResult {
  final List<String> deletedIds;
  final List<String> unselectedIds;
  final UserProfile? updatedProfile;
  final List<String> newBadgeIds;

  const ConfirmDeleteResult({
    required this.deletedIds,
    this.unselectedIds = const [],
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
        authRepository: locator(),
        subscriptionCubit: locator<SubscriptionCubit>(),
      ),
      child: ConfirmDeleteChildPage(args: args),
    );
  }
}

class ConfirmDeleteChildPage extends StatefulWidget {
  final ConfirmDeletePageArgs args;
  const ConfirmDeleteChildPage({super.key, required this.args});

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
    _cubit.init(initialItems: widget.args.itemsToDelete);
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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveValue<int>(
                context,
                conditionalValues: [
                  const Condition.equals(name: MOBILE, value: 3),
                  const Condition.largerThan(name: MOBILE, value: 5),
                ],
                defaultValue: 3,
              ).value,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: state.itemsToDelete.length,
            itemBuilder: (context, index) {
              final item = state.itemsToDelete[index];

              return ConfirmDeleteListItem(
                item: item,
                onRemove: () => _cubit.removePhoto(item.id),
              );
            },
          ),
        ),
        SafeArea(
          child: Padding(
            padding: 12.paddingAll,
            child: SizedBox(
              width: double.infinity,
              child: AppFilledButton(
                onPressed: () => _cubit.confirmDeletion(),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                text: _l10n.deleteSelectedWithCountAndSize(
                  state.itemsToDelete.length,
                  state.totalSizeBytes.formatBytes(),
                ),
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
                color: Colors.red.withValues(alpha: 0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border.all(color: Colors.red, width: 3),
              ),
              child: Text(
                S.of(context).delete_confirm_message,
                style: _theme.textTheme.titleSmall?.copyWith(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/presentation/app/cubit/subscription_cubit.dart';
import 'package:twinfix/presentation/features/confirm_delete/cubit/confirm_delete_state.dart';
import 'package:twinfix/presentation/features/confirm_delete/navigator/confirm_delete_navigator.dart';
import 'package:twinfix/presentation/features/confirm_delete/page/confirm_delete_page.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

import 'package:twinfix/core/services/ad_service.dart';

class ConfirmDeleteCubit extends BaseCubit<ConfirmDeleteState> {
  final ConfirmDeleteNavigator navigator;
  final AuthRepository authRepository;
  final SubscriptionCubit subscriptionCubit;
  final List<String> _initialIds = [];

  ConfirmDeleteCubit({
    required this.navigator,
    required this.authRepository,
    required this.subscriptionCubit,
  }) : super(ConfirmDeleteState.initial());

  //Public Methods

  void init({required List<MediaItem> initialItems}) {
    _initialIds.clear();
    for (var item in initialItems) {
      _initialIds.add(item.id);
    }

    safeEmit(
      state.copyWith(
        status: LoadStatus.success,
        itemsToDelete: initialItems,
        totalSizeBytes: _calculateTotalSize(initialItems),
      ),
    );
  }

  ConfirmDeleteResult createCancelResult() {
    return ConfirmDeleteResult(
      deletedIds: [],
      unselectedIds: _getUnselectedIds(),
    );
  }

  Future<void> confirmDeletion() async {
    if (state.itemsToDelete.isEmpty) {
      navigator.safePop(createCancelResult());
      return;
    }

    safeEmit(state.copyWith(status: LoadStatus.loading));
    try {
      final idsToDelete = state.itemsToDelete.map((e) => e.id).toList();

      // Fetch accurate file sizes before deletion concurrently to save time
      final Map<String, int> fileSizes = {};

      await Future.wait(
        state.itemsToDelete.map((item) async {
          if (item.fileSize > 0) {
            fileSizes[item.id] = item.fileSize;
          } else if (item.assetEntity != null) {
            try {
              final file = await item.assetEntity!.file;
              if (file != null) {
                fileSizes[item.id] = await file.length();
              } else {
                fileSizes[item.id] = 0;
              }
            } catch (e) {
              fileSizes[item.id] = 0;
            }
          } else {
            fileSizes[item.id] = 0;
          }
        }),
      );

      final result = await PhotoManager.editor.deleteWithIds(idsToDelete);

      if (result.isNotEmpty) {
        final deletedIds = result;

        // Count deleted photos by category among successfully deleted photos
        int blurryCount = 0;
        int duplicateCount = 0;
        int totalDeletedCount = 0;
        int totalDeletedSize = 0;

        for (var item in state.itemsToDelete) {
          if (deletedIds.contains(item.id)) {
            totalDeletedCount++;
            totalDeletedSize += (fileSizes[item.id] ?? 0);

            if (item.type.isBlurry) {
              blurryCount++;
            }
            if (item.type.isDuplicate) {
              duplicateCount++;
            }
          }
        }

        DeletionResult? deletionResult;
        if (totalDeletedCount > 0) {
          deletionResult = await authRepository.recordDeletion(
            totalCount: totalDeletedCount,
            totalDeletedSize: totalDeletedSize,
            blurryCount: blurryCount,
            duplicateCount: duplicateCount,
          );
        }

        safeEmit(state.copyWith(status: LoadStatus.success));

        final deleteResult = ConfirmDeleteResult(
          deletedIds: deletedIds,
          unselectedIds: _getUnselectedIds(),
          updatedProfile: deletionResult?.updatedProfile,
          newBadgeIds: deletionResult?.newBadgeIds ?? [],
          totalSizeDeleted: totalDeletedSize,
        );

        if (subscriptionCubit.state.isPremium) {
          navigator.safePop(deleteResult);
        } else {
          await AdService.showInterstitialAd(
            onAdClosed: () {
              navigator.safePop(deleteResult);
            },
          );
        }
      } else {
        safeEmit(state.copyWith(status: LoadStatus.success));
        navigator.safePop(createCancelResult());
      }
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  //Privated Methods

  List<String> _getUnselectedIds() {
    final currentIds = state.itemsToDelete.map((e) => e.id).toList();

    return _initialIds.where((id) => !currentIds.contains(id)).toList();
  }

  int _calculateTotalSize(List<MediaItem> items) {
    int total = 0;
    for (var item in items) {
      total += item.fileSize;
    }
    return total;
  }

  void removePhoto(String id) {
    final updatedList = state.itemsToDelete.where((p) => p.id != id).toList();
    safeEmit(
      state.copyWith(
        itemsToDelete: updatedList,
        totalSizeBytes: _calculateTotalSize(updatedList),
      ),
    );
  }
}

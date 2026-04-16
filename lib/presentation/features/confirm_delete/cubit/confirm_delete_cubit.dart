import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/repositories/user_repository.dart';
import 'package:twinfix/domain/entities/media_item.dart';
import 'package:twinfix/domain/enums/photo_type.dart';
import 'package:twinfix/presentation/features/confirm_delete/cubit/confirm_delete_state.dart';
import 'package:twinfix/presentation/features/confirm_delete/navigator/confirm_delete_navigator.dart';
import 'package:twinfix/presentation/features/confirm_delete/page/confirm_delete_page.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class ConfirmDeleteCubit extends BaseCubit<ConfirmDeleteState> {
  final ConfirmDeleteNavigator navigator;
  final UserRepository userRepository;
  final List<String> _initialIds = [];

  ConfirmDeleteCubit({required this.navigator, required this.userRepository})
    : super(ConfirmDeleteState.initial());

  void init(List<MediaItem> initialItems) {
    _initialIds.clear();
    for (var item in initialItems) {
      _initialIds.add(item.id);
    }

    safeEmit(
      state.copyWith(status: LoadStatus.success, itemsToDelete: initialItems),
    );
  }

  ConfirmDeleteResult createCancelResult() {
    return ConfirmDeleteResult(
      deletedIds: [],
      unselectedIds: _getUnselectedIds(),
    );
  }

  List<String> _getUnselectedIds() {
    final currentIds = state.itemsToDelete.map((e) => e.id).toList();

    return _initialIds.where((id) => !currentIds.contains(id)).toList();
  }

  void removePhoto(String id) {
    final updatedList = state.itemsToDelete.where((p) => p.id != id).toList();
    safeEmit(state.copyWith(itemsToDelete: updatedList));
  }

  Future<void> confirmDeletion() async {
    if (state.itemsToDelete.isEmpty) {
      navigator.safePop(createCancelResult());
      return;
    }

    safeEmit(state.copyWith(status: LoadStatus.loading));
    try {
      final idsToDelete = state.itemsToDelete.map((e) => e.id).toList();

      final result = await PhotoManager.editor.deleteWithIds(idsToDelete);

      if (result.isNotEmpty) {
        int totalSaved = 0;
        final deletedIds = result;

        // Đếm số ảnh theo loại trong các ảnh đã xóa thành công
        int blurryCount = 0;
        int duplicateCount = 0;
        int totalDeletedCount = 0;

        for (var item in state.itemsToDelete) {
          if (deletedIds.contains(item.id)) {
            totalSaved += item.sizeBytes;
            totalDeletedCount++;

            if (item.type.isBlurry) {
              blurryCount++;
            }
            if (item.type.isDuplicate) {
              duplicateCount++;
            }
          }
        }

        DeletionResult? deletionResult;
        if (totalSaved > 0 || totalDeletedCount > 0) {
          deletionResult = await userRepository.recordDeletion(
            bytesFreed: totalSaved,
            totalCount: totalDeletedCount,
            blurryCount: blurryCount,
            duplicateCount: duplicateCount,
          );
        }

        safeEmit(state.copyWith(status: LoadStatus.success));
        navigator.safePop(
          ConfirmDeleteResult(
            deletedIds: deletedIds,
            unselectedIds: _getUnselectedIds(),
            bytesSaved: totalSaved,
            updatedProfile: deletionResult?.updatedProfile,
            newBadgeIds: deletionResult?.newBadgeIds ?? [],
          ),
        );
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
}

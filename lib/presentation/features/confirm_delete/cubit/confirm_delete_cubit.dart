import 'package:photo_manager/photo_manager.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/repositories/user_repository.dart';
import 'package:twinfix/domain/entities/photo_item.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
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

  void init(List<dynamic> initialItems) {
    _initialIds.clear();
    for (var item in initialItems) {
      if (item is PhotoItem) {
        _initialIds.add(item.id);
      } else if (item is AssetEntity) {
        _initialIds.add(item.id);
      }
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
    final currentIds = state.itemsToDelete.map((e) {
      if (e is PhotoItem) return e.id;
      if (e is AssetEntity) return e.id;
      return '';
    }).toList();

    return _initialIds.where((id) => !currentIds.contains(id)).toList();
  }

  void removePhoto(String id) {
    final updatedList = state.itemsToDelete.where((p) {
      if (p is PhotoItem) return p.id != id;
      if (p is AssetEntity) return p.id != id;
      return true;
    }).toList();
    safeEmit(state.copyWith(itemsToDelete: updatedList));
  }

  Future<void> confirmDeletion() async {
    if (state.itemsToDelete.isEmpty) {
      navigator.safePop(createCancelResult());
      return;
    }

    safeEmit(state.copyWith(status: LoadStatus.loading));
    try {
      final idsToDelete = state.itemsToDelete.map((e) {
        if (e is PhotoItem) return e.id;
        if (e is AssetEntity) return e.id;
        return '';
      }).toList();

      final result = await PhotoManager.editor.deleteWithIds(idsToDelete);

      if (result.isNotEmpty) {
        int totalSaved = 0;
        final deletedIds = result;

        for (var item in state.itemsToDelete) {
          String itemId = '';
          if (item is PhotoItem) itemId = item.id;
          if (item is AssetEntity) itemId = item.id;

          if (deletedIds.contains(itemId)) {
            if (item is PhotoItem) {
              totalSaved += item.sizeBytes;
            } else if (item is AssetEntity) {
              final file = await item.file;
              if (file != null) {
                totalSaved += await file.length();
              }
            }
          }
        }

        UserProfile? updatedProfile;
        if (totalSaved > 0) {
          updatedProfile = await userRepository.addCleanedBytes(totalSaved);
        }

        safeEmit(state.copyWith(status: LoadStatus.success));
        navigator.safePop(
          ConfirmDeleteResult(
            deletedIds: deletedIds,
            unselectedIds: _getUnselectedIds(),
            bytesSaved: totalSaved,
            updatedProfile: updatedProfile,
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

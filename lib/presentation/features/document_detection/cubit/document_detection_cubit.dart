import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'document_detection_state.dart';
import '../navigator/document_detection_navigator.dart';

class DocumentDetectionCubit extends BaseCubit<DocumentDetectionState> {
  final PhotoRepository _photoRepository;
  final DocumentDetectionNavigator navigator;

  DocumentDetectionCubit(this._photoRepository, this.navigator)
    : super(const DocumentDetectionState());

  Future<void> startScan() async {
    if (state.status.isLoading) return;
    safeEmit(state.copyWith(status: LoadStatus.loading));
    await Future.delayed(1.seconds);
    try {
      final documents = await _photoRepository.getDocuments();
      safeEmit(
        state.copyWith(status: LoadStatus.success, documents: documents),
      );
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void toggleSelection({required String id}) {
    final selectedIds = state.selectedIds;
    if (selectedIds.contains(id)) {
      safeEmit(
        state.copyWith(selectedIds: selectedIds.where((e) => e != id).toList()),
      );
    } else {
      safeEmit(state.copyWith(selectedIds: [...selectedIds, id]));
    }
  }

  void clearSelection() {
    safeEmit(state.copyWith(selectedIds: []));
  }

  Future<void> deleteDocuments({required List<String> ids}) async {
    if (ids.isEmpty) return;
    if (state.status.isLoading) return;
    safeEmit(state.copyWith(status: LoadStatus.loading));
    try {
      await _photoRepository.deleteAssets(ids);
      final newDocuments = state.documents
          .where((e) => !ids.contains(e.id))
          .toList();
      safeEmit(
        state.copyWith(status: LoadStatus.success, documents: newDocuments),
      );
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}

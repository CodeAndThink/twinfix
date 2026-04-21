import 'package:injectable/injectable.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'document_detection_state.dart';

@injectable
class DocumentDetectionCubit extends BaseCubit<DocumentDetectionState> {
  final PhotoRepository _photoRepository;

  DocumentDetectionCubit(this._photoRepository)
    : super(const DocumentDetectionState());

  Future<void> startScan() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final documents = await _photoRepository.getDocuments();
      emit(state.copyWith(status: LoadStatus.success, documents: documents));
    } catch (e) {
      emit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void toggleSelection({required String id}) {
    final selectedIds = state.selectedIds;
    if (selectedIds.contains(id)) {
      emit(
        state.copyWith(selectedIds: selectedIds.where((e) => e != id).toList()),
      );
    } else {
      emit(state.copyWith(selectedIds: [...selectedIds, id]));
    }
  }

  void clearSelection() {
    emit(state.copyWith(selectedIds: []));
  }

  Future<void> deleteDocuments({required List<String> ids}) async {
    try {
      await _photoRepository.deleteAssets(ids);
      final newDocuments = state.documents
          .where((e) => !ids.contains(e.id))
          .toList();
      emit(state.copyWith(documents: newDocuments));
    } catch (e) {
      emit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}

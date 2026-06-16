import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/core/services/scan_foreground_service.dart';
import 'package:twinfix/domain/enums/scan_type.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/generated/l10n.dart';
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

    await ScanForegroundService.instance.start(
      title: S.current.notifScanningTitle,
      body: S.current.scanningDocument,
    );

    try {
      final documents = await _photoRepository.getDocuments(
        onProgress: (current, total) {
          safeEmit(state.copyWith(scanProgress: current, scanTotal: total));
          ScanForegroundService.instance.updateProgress(
            title: S.current.notifScanningTitle,
            body: S.current.notifScanningBody(current, total),
            current: current,
            total: total,
          );
        },
      );

      final count = documents.length;
      await ScanForegroundService.instance.stop(
        resultCount: count,
        completionTitle: S.current.notifScanCompleteTitle,
        completionBody: count > 0
            ? S.current.notifScanCompleteDocuments(count)
            : S.current.notifScanCompleteNone,
        scanType: ScanType.documents,
      );

      safeEmit(
        state.copyWith(status: LoadStatus.success, documents: documents),
      );
    } catch (e) {
      await ScanForegroundService.instance.cancel();
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

  void removeDocumentsFromList({required List<String> ids}) {
    if (ids.isEmpty) return;

    final newDocuments = state.documents
        .where((e) => !ids.contains(e.id))
        .toList();
    safeEmit(
      state.copyWith(status: LoadStatus.success, documents: newDocuments),
    );
  }

  @override
  Future<void> close() {
    _photoRepository.cancelDocumentScan();
    ScanForegroundService.instance.cancel();
    return super.close();
  }
}

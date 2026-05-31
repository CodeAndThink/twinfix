import 'package:twinfix/core/configs/app_configs.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'history_state.dart';

class HistoryCubit extends BaseCubit<HistoryState> {
  final AuthRepository authRepository;

  HistoryCubit({required this.authRepository}) : super(HistoryState.initial());

  Future<void> init() async {
    safeEmit(state.copyWith(status: LoadStatus.loading));
    try {
      final items = await authRepository.getDeletionHistory(
        limit: AppConfigs.historyPageSize,
        offset: 0,
      );
      final hasMore = items.length == AppConfigs.historyPageSize;
      safeEmit(
        state.copyWith(
          status: LoadStatus.success,
          history: items,
          hasMore: hasMore,
        ),
      );
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.status.isLoading || !state.hasMore) return;

    safeEmit(state.copyWith(status: LoadStatus.loading));
    try {
      final currentOffset = state.history.length;
      final newItems = await authRepository.getDeletionHistory(
        limit: AppConfigs.historyPageSize,
        offset: currentOffset,
      );
      final hasMore = newItems.length == AppConfigs.historyPageSize;
      safeEmit(
        state.copyWith(
          status: LoadStatus.success,
          history: [...state.history, ...newItems],
          hasMore: hasMore,
        ),
      );
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}

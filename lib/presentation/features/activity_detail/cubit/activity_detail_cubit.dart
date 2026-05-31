import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';
import 'package:twinfix/presentation/features/activity_detail/cubit/activity_detail_state.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import '../navigator/activity_detail_navigator.dart';

class ActivityDetailCubit extends BaseCubit<ActivityDetailState> {
  final AuthRepository authRepository;
  final ActivityDetailNavigator navigator;

  ActivityDetailCubit({required this.authRepository, required this.navigator})
    : super(ActivityDetailState.initial());

  Future<void> init() async {
    safeEmit(state.copyWith(status: LoadStatus.loading));
    try {
      final history = await authRepository.getDeletionHistory();
      safeEmit(state.copyWith(status: LoadStatus.success, history: history));
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}

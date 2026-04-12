import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:twinfix/domain/entities/user_profile.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'package:twinfix/core/repositories/user_repository.dart';
import 'package:twinfix/core/enums/load_status.dart';

import 'package:storage_space/storage_space.dart';

part 'dashboard_state.dart';

@injectable
class DashboardCubit extends BaseCubit<DashboardState> {
  final UserRepository userRepository;
  final AppCubit globalAppCubit;

  DashboardCubit({required this.userRepository, required this.globalAppCubit})
    : super(DashboardState.initial());

  Future<void> loadProfile() async {
    try {
      safeEmit(state.copyWith(status: LoadStatus.loading));

      // Lấy dung lượng bộ nhớ thực tế
      final storage = await getStorageSpace(
        lowOnSpaceThreshold: 2 * 1024 * 1024 * 1024, // 2GB
        fractionDigits: 1,
      );
      final usagePercent = storage.usageValue * 100;

      final profile = await userRepository.getUserProfile();
      safeEmit(
        state.copyWith(
          status: LoadStatus.success,
          profile: profile,
          storageUsagePercent: usagePercent,
        ),
      );
    } catch (e) {
      safeEmit(
        state.copyWith(status: LoadStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}

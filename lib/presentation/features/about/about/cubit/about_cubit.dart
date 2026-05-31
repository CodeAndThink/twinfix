import 'package:package_info_plus/package_info_plus.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'about_state.dart';
import '../navigator/about_navigator.dart';

class AboutCubit extends BaseCubit<AboutState> {
  final AboutNavigator navigator;

  AboutCubit({required this.navigator}) : super(AboutState());

  Future<void> loadVersion() async {
    safeEmit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      safeEmit(
        state.copyWith(
          version: packageInfo.version,
          loadStatus: LoadStatus.success,
        ),
      );
    } catch (_) {
      safeEmit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }
}

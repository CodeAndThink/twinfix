import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinfix/core/configs/app_configs.dart';
import 'package:twinfix/core/constants/key_constants.dart';
import 'package:twinfix/presentation/features/settings/cubit/settings_state.dart';
import 'package:twinfix/presentation/features/settings/navigator/settings_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class SettingsCubit extends BaseCubit<SettingsState> {
  final SettingsNavigator navigator;
  final SharedPreferences prefs;

  SettingsCubit({required this.navigator, required this.prefs})
    : super(SettingsState()) {
    _loadInitialState();
  }

  void _loadInitialState() {
    final scanLimit =
        prefs.getInt(KeyConstants.scanLimit) ?? AppConfigs.maxLimitScanPhoto;

    safeEmit(state.copyWith(maxLimitScanPhoto: scanLimit));
  }

  void updateScanLimit(int limit) {
    prefs.setInt(KeyConstants.scanLimit, limit);
    safeEmit(state.copyWith(maxLimitScanPhoto: limit));
  }
}

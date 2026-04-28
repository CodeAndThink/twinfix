import 'package:twinfix/presentation/features/settings/cubit/settings_state.dart';
import 'package:twinfix/presentation/features/settings/navigator/settings_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class SettingsCubit extends BaseCubit<SettingsState> {
  final SettingsNavigator navigator;

  SettingsCubit({required this.navigator}) : super(SettingsState());
}

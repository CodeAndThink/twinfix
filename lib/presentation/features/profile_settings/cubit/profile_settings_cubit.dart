import 'package:twinfix/presentation/features/profile_settings/cubit/profile_settings_state.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'package:twinfix/presentation/features/profile_settings/navigator/profile_settings_navigator.dart';

class ProfileSettingsCubit extends BaseCubit<ProfileSettingsState> {
  final ProfileSettingsNavigator navigator;

  ProfileSettingsCubit({required this.navigator})
    : super(const ProfileSettingsState());
}

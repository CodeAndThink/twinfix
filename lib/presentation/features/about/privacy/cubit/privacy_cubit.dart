import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'privacy_state.dart';
import '../navigator/privacy_navigator.dart';

class PrivacyCubit extends BaseCubit<PrivacyState> {
  final PrivacyNavigator navigator;

  PrivacyCubit({required this.navigator}) : super(PrivacyState.initial());
}

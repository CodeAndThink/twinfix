import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'terms_of_service_state.dart';
import '../navigator/terms_of_service_navigator.dart';

class TermsOfServiceCubit extends BaseCubit<TermsOfServiceState> {
  final TermsOfServiceNavigator navigator;

  TermsOfServiceCubit({required this.navigator})
    : super(TermsOfServiceState.initial());
}

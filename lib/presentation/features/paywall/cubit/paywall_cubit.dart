import 'package:twinfix/presentation/features/paywall/navigator/paywall_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'package:twinfix/presentation/features/paywall/cubit/paywall_state.dart';

class PaywallCubit extends BaseCubit<PaywallState> {
  final PaywallNavigator navigator;
  PaywallCubit({required this.navigator}) : super(const PaywallState());
}

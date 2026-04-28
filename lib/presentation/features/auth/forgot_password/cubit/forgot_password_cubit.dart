import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/presentation/features/auth/forgot_password/cubit/forgot_password_state.dart';
import 'package:twinfix/presentation/features/auth/forgot_password/navigator/forgot_password_navigator.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

class ForgotPasswordCubit extends BaseCubit<ForgotPasswordState> {
  final ForgotPasswordNavigator navigator;

  ForgotPasswordCubit({required this.navigator})
    : super(const ForgotPasswordState());

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  Future<void> sendResetLink() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      // TODO: Call forgot password usecase here
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(loadStatus: LoadStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          loadStatus: LoadStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

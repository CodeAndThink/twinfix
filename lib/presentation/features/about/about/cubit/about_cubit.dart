import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'about_state.dart';
import '../navigator/about_navigator.dart';

class AboutCubit extends BaseCubit<AboutState> {
  final AboutNavigator navigator;

  AboutCubit({required this.navigator}) : super(AboutState.initial());
}

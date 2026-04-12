import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';

part 'locale_state.dart';

@lazySingleton
class LocaleCubit extends BaseCubit<LocaleState> {
  LocaleCubit() : super(const LocaleState(Locale('en')));

  void changeLanguage(String languageCode) {
    safeEmit(LocaleState(Locale(languageCode)));
  }
}

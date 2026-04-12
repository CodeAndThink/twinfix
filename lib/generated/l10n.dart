// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Twinfix`
  String get appName {
    return Intl.message('Twinfix', name: 'appName', desc: '', args: []);
  }

  /// `Scanning device...`
  String get scanningDevice {
    return Intl.message(
      'Scanning device...',
      name: 'scanningDevice',
      desc: '',
      args: [],
    );
  }

  /// `Perfect!`
  String get perfect {
    return Intl.message('Perfect!', name: 'perfect', desc: '', args: []);
  }

  /// `Your device is very clean.`
  String get deviceIsClean {
    return Intl.message(
      'Your device is very clean.',
      name: 'deviceIsClean',
      desc: '',
      args: [],
    );
  }

  /// `Detected {count} duplicate photos`
  String detectedDuplicates(int count) {
    return Intl.message(
      'Detected $count duplicate photos',
      name: 'detectedDuplicates',
      desc: '',
      args: [count],
    );
  }

  /// `Error: {message}`
  String error(String message) {
    return Intl.message(
      'Error: $message',
      name: 'error',
      desc: '',
      args: [message],
    );
  }

  /// `ID: {id}`
  String photoId(String id) {
    return Intl.message('ID: $id', name: 'photoId', desc: '', args: [id]);
  }

  /// `Scan`
  String get tabScan {
    return Intl.message('Scan', name: 'tabScan', desc: '', args: []);
  }

  /// `Achievements`
  String get tabDashboard {
    return Intl.message(
      'Achievements',
      name: 'tabDashboard',
      desc: '',
      args: [],
    );
  }

  /// `Level {level}`
  String level(int level) {
    return Intl.message('Level $level', name: 'level', desc: '', args: [level]);
  }

  /// `{days} Days Streak`
  String streakDays(int days) {
    return Intl.message(
      '$days Days Streak',
      name: 'streakDays',
      desc: '',
      args: [days],
    );
  }

  /// `Cleaned Data`
  String get cleanedData {
    return Intl.message(
      'Cleaned Data',
      name: 'cleanedData',
      desc: '',
      args: [],
    );
  }

  /// `Badges`
  String get badges {
    return Intl.message('Badges', name: 'badges', desc: '', args: []);
  }

  /// `Welcome to Twinfix`
  String get onboardingWelcomeTitle {
    return Intl.message(
      'Welcome to Twinfix',
      name: 'onboardingWelcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `All your photos are processed offline. Your data never leaves your device!`
  String get onboardingPrivacyMsg {
    return Intl.message(
      'All your photos are processed offline. Your data never leaves your device!',
      name: 'onboardingPrivacyMsg',
      desc: '',
      args: [],
    );
  }

  /// `Start Scanning`
  String get onboardingStartScan {
    return Intl.message(
      'Start Scanning',
      name: 'onboardingStartScan',
      desc: '',
      args: [],
    );
  }

  /// `Swipe Left to Delete`
  String get onboardingDemoSwipeLeft {
    return Intl.message(
      'Swipe Left to Delete',
      name: 'onboardingDemoSwipeLeft',
      desc: '',
      args: [],
    );
  }

  /// `Swipe Right to Keep`
  String get onboardingDemoSwipeRight {
    return Intl.message(
      'Swipe Right to Keep',
      name: 'onboardingDemoSwipeRight',
      desc: '',
      args: [],
    );
  }

  /// `Storage almost full!`
  String get memoryWarning {
    return Intl.message(
      'Storage almost full!',
      name: 'memoryWarning',
      desc: '',
      args: [],
    );
  }

  /// `Storage almost full ({percent}%), clean up now!`
  String storageAlmostFull(int percent) {
    return Intl.message(
      'Storage almost full ($percent%), clean up now!',
      name: 'storageAlmostFull',
      desc: '',
      args: [percent],
    );
  }

  /// `Quick Scan`
  String get quickScan {
    return Intl.message('Quick Scan', name: 'quickScan', desc: '', args: []);
  }

  /// `Deep Scan`
  String get deepScan {
    return Intl.message('Deep Scan', name: 'deepScan', desc: '', args: []);
  }

  /// `Detected {count} duplicate groups`
  String detectedDuplicateGroups(int count) {
    return Intl.message(
      'Detected $count duplicate groups',
      name: 'detectedDuplicateGroups',
      desc: '',
      args: [count],
    );
  }

  /// `Group {index} ({count} photos)`
  String groupIndex(int index, int count) {
    return Intl.message(
      'Group $index ($count photos)',
      name: 'groupIndex',
      desc: '',
      args: [index, count],
    );
  }

  /// `Long press to select all`
  String get longPressToSelectAll {
    return Intl.message(
      'Long press to select all',
      name: 'longPressToSelectAll',
      desc: '',
      args: [],
    );
  }

  /// `Clear selection`
  String get clearSelection {
    return Intl.message(
      'Clear selection',
      name: 'clearSelection',
      desc: '',
      args: [],
    );
  }

  /// `Delete ({count})`
  String deleteSelected(int count) {
    return Intl.message(
      'Delete ($count)',
      name: 'deleteSelected',
      desc: '',
      args: [count],
    );
  }

  /// `Confirm delete`
  String get confirmDelete {
    return Intl.message(
      'Confirm delete',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete {count} photos?`
  String confirmDeleteMessage(int count) {
    return Intl.message(
      'Are you sure you want to delete $count photos?',
      name: 'confirmDeleteMessage',
      desc: '',
      args: [count],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Delete duplicate photos`
  String get deleteDuplicates {
    return Intl.message(
      'Delete duplicate photos',
      name: 'deleteDuplicates',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete {count} duplicate photos?`
  String deleteDuplicatesMessage(int count) {
    return Intl.message(
      'Are you sure you want to delete $count duplicate photos?',
      name: 'deleteDuplicatesMessage',
      desc: '',
      args: [count],
    );
  }

  /// `Swipe left to delete, keep right`
  String get swipeLeftToDeleteKeepRight {
    return Intl.message(
      'Swipe left to delete, keep right',
      name: 'swipeLeftToDeleteKeepRight',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

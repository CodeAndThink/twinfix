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
  String detectedDuplicates(Object count) {
    return Intl.message(
      'Detected $count duplicate photos',
      name: 'detectedDuplicates',
      desc: '',
      args: [count],
    );
  }

  /// `Error: {message}`
  String error(Object message) {
    return Intl.message(
      'Error: $message',
      name: 'error',
      desc: '',
      args: [message],
    );
  }

  /// `ID: {id}`
  String photoId(Object id) {
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
  String level(Object level) {
    return Intl.message('Level $level', name: 'level', desc: '', args: [level]);
  }

  /// `{days} Days Streak`
  String streakDays(Object days) {
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
  String storageAlmostFull(Object percent) {
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
  String detectedDuplicateGroups(Object count) {
    return Intl.message(
      'Detected $count duplicate groups',
      name: 'detectedDuplicateGroups',
      desc: '',
      args: [count],
    );
  }

  /// `Group {index} ({count} photos)`
  String groupIndex(Object index, Object count) {
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
  String deleteSelected(Object count) {
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

  /// `Are you sure you want to delete {count} photos? They will be moved to the system trash. You may need to empty the trash to free up storage.`
  String confirmDeleteMessage(Object count) {
    return Intl.message(
      'Are you sure you want to delete $count photos? They will be moved to the system trash. You may need to empty the trash to free up storage.',
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

  /// `Are you sure you want to delete {count} duplicate photos? They will be moved to the system trash.`
  String deleteDuplicatesMessage(Object count) {
    return Intl.message(
      'Are you sure you want to delete $count duplicate photos? They will be moved to the system trash.',
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

  /// `Scan results`
  String get scanResults {
    return Intl.message(
      'Scan results',
      name: 'scanResults',
      desc: '',
      args: [],
    );
  }

  /// `Photo Duplicate Cleaner`
  String get appDescription {
    return Intl.message(
      'Photo Duplicate Cleaner',
      name: 'appDescription',
      desc: '',
      args: [],
    );
  }

  /// `To next level ({percent})`
  String toNextLevel(Object percent) {
    return Intl.message(
      'To next level ($percent)',
      name: 'toNextLevel',
      desc: '',
      args: [percent],
    );
  }

  /// `How to earn?`
  String get howToEarn {
    return Intl.message('How to earn?', name: 'howToEarn', desc: '', args: []);
  }

  /// `You need to perform more system cleaning steps or invite friends to get this prestigious badge.`
  String get howToEarnDescription {
    return Intl.message(
      'You need to perform more system cleaning steps or invite friends to get this prestigious badge.',
      name: 'howToEarnDescription',
      desc: '',
      args: [],
    );
  }

  /// `Unlocked`
  String get earned {
    return Intl.message('Unlocked', name: 'earned', desc: '', args: []);
  }

  /// `Requirements not met`
  String get notEarned {
    return Intl.message(
      'Requirements not met',
      name: 'notEarned',
      desc: '',
      args: [],
    );
  }

  /// `Achievements`
  String get achievements {
    return Intl.message(
      'Achievements',
      name: 'achievements',
      desc: '',
      args: [],
    );
  }

  /// `Collect all badges to become a cleaning master!`
  String get achievementsDescription {
    return Intl.message(
      'Collect all badges to become a cleaning master!',
      name: 'achievementsDescription',
      desc: '',
      args: [],
    );
  }

  /// `You unlocked {count} badges`
  String achievementsEarned(Object count) {
    return Intl.message(
      'You unlocked $count badges',
      name: 'achievementsEarned',
      desc: '',
      args: [count],
    );
  }

  /// `You unlocked {count} out of {total} badges`
  String achievementsEarnedDescription(Object count, Object total) {
    return Intl.message(
      'You unlocked $count out of $total badges',
      name: 'achievementsEarnedDescription',
      desc: '',
      args: [count, total],
    );
  }

  /// `You have {count} badges left to unlock`
  String achievementsNotEarned(Object count) {
    return Intl.message(
      'You have $count badges left to unlock',
      name: 'achievementsNotEarned',
      desc: '',
      args: [count],
    );
  }

  /// `You have {count} badges left to unlock out of {total} total badges`
  String achievementsNotEarnedDescription(Object count, Object total) {
    return Intl.message(
      'You have $count badges left to unlock out of $total total badges',
      name: 'achievementsNotEarnedDescription',
      desc: '',
      args: [count, total],
    );
  }

  /// `Total {count} badges`
  String achievementsTotal(Object count) {
    return Intl.message(
      'Total $count badges',
      name: 'achievementsTotal',
      desc: '',
      args: [count],
    );
  }

  /// `Total {count} badges out of {total} total badges`
  String achievementsTotalDescription(Object count, Object total) {
    return Intl.message(
      'Total $count badges out of $total total badges',
      name: 'achievementsTotalDescription',
      desc: '',
      args: [count, total],
    );
  }

  /// `Total {count} badges earned`
  String achievementsEarnedTotal(Object count) {
    return Intl.message(
      'Total $count badges earned',
      name: 'achievementsEarnedTotal',
      desc: '',
      args: [count],
    );
  }

  /// `You have unlocked {count} badges out of {total} total badges`
  String achievementsEarnedTotalDescription(Object count, Object total) {
    return Intl.message(
      'You have unlocked $count badges out of $total total badges',
      name: 'achievementsEarnedTotalDescription',
      desc: '',
      args: [count, total],
    );
  }

  /// `Total {count} badges not yet earned`
  String achievementsNotEarnedTotal(Object count) {
    return Intl.message(
      'Total $count badges not yet earned',
      name: 'achievementsNotEarnedTotal',
      desc: '',
      args: [count],
    );
  }

  /// `You have {count} badges remaining out of {total} total badges`
  String achievementsNotEarnedTotalDescription(Object count, Object total) {
    return Intl.message(
      'You have $count badges remaining out of $total total badges',
      name: 'achievementsNotEarnedTotalDescription',
      desc: '',
      args: [count, total],
    );
  }

  /// `No duplicate photos found`
  String get noDuplicatesFound {
    return Intl.message(
      'No duplicate photos found',
      name: 'noDuplicatesFound',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get tabSettings {
    return Intl.message('Settings', name: 'tabSettings', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Background Style`
  String get backgroundStyle {
    return Intl.message(
      'Background Style',
      name: 'backgroundStyle',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get themeLight {
    return Intl.message('Light', name: 'themeLight', desc: '', args: []);
  }

  /// `Dark`
  String get themeDark {
    return Intl.message('Dark', name: 'themeDark', desc: '', args: []);
  }

  /// `System`
  String get themeSystem {
    return Intl.message('System', name: 'themeSystem', desc: '', args: []);
  }

  /// `Clean`
  String get bgNone {
    return Intl.message('Clean', name: 'bgNone', desc: '', args: []);
  }

  /// `Premium Abstract`
  String get bgPremium {
    return Intl.message(
      'Premium Abstract',
      name: 'bgPremium',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Vietnamese`
  String get vietnamese {
    return Intl.message('Vietnamese', name: 'vietnamese', desc: '', args: []);
  }

  /// `Appearance`
  String get appearance {
    return Intl.message('Appearance', name: 'appearance', desc: '', args: []);
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `Dragon Boat`
  String get bgNature1 {
    return Intl.message('Dragon Boat', name: 'bgNature1', desc: '', args: []);
  }

  /// `Forest Lake`
  String get bgNature2 {
    return Intl.message('Forest Lake', name: 'bgNature2', desc: '', args: []);
  }

  /// `Mountain`
  String get bgNature3 {
    return Intl.message('Mountain', name: 'bgNature3', desc: '', args: []);
  }

  /// `Sunset`
  String get bgNature4 {
    return Intl.message('Sunset', name: 'bgNature4', desc: '', args: []);
  }

  /// `Gallery Manager`
  String get galleryManager {
    return Intl.message(
      'Gallery Manager',
      name: 'galleryManager',
      desc: '',
      args: [],
    );
  }

  /// `{count} photos`
  String totalPhotos(Object count) {
    return Intl.message(
      '$count photos',
      name: 'totalPhotos',
      desc: '',
      args: [count],
    );
  }

  /// `Date Descending`
  String get dateDesc {
    return Intl.message(
      'Date Descending',
      name: 'dateDesc',
      desc: '',
      args: [],
    );
  }

  /// `Date Ascending`
  String get dateAsc {
    return Intl.message('Date Ascending', name: 'dateAsc', desc: '', args: []);
  }

  /// `Size Descending`
  String get sizeDesc {
    return Intl.message(
      'Size Descending',
      name: 'sizeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Size Ascending`
  String get sizeAsc {
    return Intl.message('Size Ascending', name: 'sizeAsc', desc: '', args: []);
  }

  /// `Name Descending`
  String get nameDesc {
    return Intl.message(
      'Name Descending',
      name: 'nameDesc',
      desc: '',
      args: [],
    );
  }

  /// `Name Ascending`
  String get nameAsc {
    return Intl.message('Name Ascending', name: 'nameAsc', desc: '', args: []);
  }

  /// `Sort`
  String get sort {
    return Intl.message('Sort', name: 'sort', desc: '', args: []);
  }

  /// `Delete {count} photos`
  String deleteSelectedPhotos(Object count) {
    return Intl.message(
      'Delete $count photos',
      name: 'deleteSelectedPhotos',
      desc: '',
      args: [count],
    );
  }

  /// `Are you sure you want to delete {count} photos? They will be moved to the system trash. You may need to empty the trash to free up storage.`
  String deleteSelectedPhotosMessage(Object count) {
    return Intl.message(
      'Are you sure you want to delete $count photos? They will be moved to the system trash. You may need to empty the trash to free up storage.',
      name: 'deleteSelectedPhotosMessage',
      desc: '',
      args: [count],
    );
  }

  /// `Deleted {count} photos successfully`
  String deleteSuccess(Object count) {
    return Intl.message(
      'Deleted $count photos successfully',
      name: 'deleteSuccess',
      desc: '',
      args: [count],
    );
  }

  /// `Successfully cleaned {size}`
  String cleanedSpaceSuccess(Object size) {
    return Intl.message(
      'Successfully cleaned $size',
      name: 'cleanedSpaceSuccess',
      desc: '',
      args: [size],
    );
  }

  /// `Calculating...`
  String get calculatingProgress {
    return Intl.message(
      'Calculating...',
      name: 'calculatingProgress',
      desc: '',
      args: [],
    );
  }

  /// `Link guest data?`
  String get syncDataTitle {
    return Intl.message(
      'Link guest data?',
      name: 'syncDataTitle',
      desc: '',
      args: [],
    );
  }

  /// `We found some local cleaning data from your guest session. Would you like to merge it into your new account?`
  String get syncDataMessage {
    return Intl.message(
      'We found some local cleaning data from your guest session. Would you like to merge it into your new account?',
      name: 'syncDataMessage',
      desc: '',
      args: [],
    );
  }

  /// `Merge Data`
  String get mergeData {
    return Intl.message('Merge Data', name: 'mergeData', desc: '', args: []);
  }

  /// `Start Fresh`
  String get startFresh {
    return Intl.message('Start Fresh', name: 'startFresh', desc: '', args: []);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Not logged in (Guest)`
  String get notLoggedIn {
    return Intl.message(
      'Not logged in (Guest)',
      name: 'notLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Log in to sync your progress across devices`
  String get loginToSync {
    return Intl.message(
      'Log in to sync your progress across devices',
      name: 'loginToSync',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message('Log out', name: 'logout', desc: '', args: []);
  }

  /// `Logged in as {email}`
  String loggedInAs(Object email) {
    return Intl.message(
      'Logged in as $email',
      name: 'loggedInAs',
      desc: '',
      args: [email],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Streaks`
  String get streaks {
    return Intl.message('Streaks', name: 'streaks', desc: '', args: []);
  }

  /// `Progress`
  String get progress {
    return Intl.message('Progress', name: 'progress', desc: '', args: []);
  }

  /// `Stats`
  String get stats {
    return Intl.message('Stats', name: 'stats', desc: '', args: []);
  }

  /// `Other Features`
  String get tabOtherFeatures {
    return Intl.message(
      'Other Features',
      name: 'tabOtherFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message('Or', name: 'or', desc: '', args: []);
  }

  /// `Photo`
  String get media_photo {
    return Intl.message('Photo', name: 'media_photo', desc: '', args: []);
  }

  /// `Video`
  String get media_video {
    return Intl.message('Video', name: 'media_video', desc: '', args: []);
  }

  /// `Audio`
  String get media_audio {
    return Intl.message('Audio', name: 'media_audio', desc: '', args: []);
  }

  /// `Document`
  String get media_document {
    return Intl.message('Document', name: 'media_document', desc: '', args: []);
  }

  /// `Other`
  String get media_other {
    return Intl.message('Other', name: 'media_other', desc: '', args: []);
  }

  /// `Media Type Selection`
  String get media_type_selection {
    return Intl.message(
      'Media Type Selection',
      name: 'media_type_selection',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Start a quick scan`
  String get startQuickScan {
    return Intl.message(
      'Start a quick scan',
      name: 'startQuickScan',
      desc: '',
      args: [],
    );
  }

  /// `Use this button to scan your library and detect duplicates in one flow.`
  String get startQuickScanDescription {
    return Intl.message(
      'Use this button to scan your library and detect duplicates in one flow.',
      name: 'startQuickScanDescription',
      desc: '',
      args: [],
    );
  }

  /// `Open Gallery Manager`
  String get openGalleryManager {
    return Intl.message(
      'Open Gallery Manager',
      name: 'openGalleryManager',
      desc: '',
      args: [],
    );
  }

  /// `If you want to clean manually by media type, go here. Tap the highlighted button to open it.`
  String get openGalleryManagerDescription {
    return Intl.message(
      'If you want to clean manually by media type, go here. Tap the highlighted button to open it.',
      name: 'openGalleryManagerDescription',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Got it`
  String get done {
    return Intl.message('Got it', name: 'done', desc: '', args: []);
  }

  /// `Please double-check one last time!\nThis action cannot be undone.`
  String get delete_confirm_message {
    return Intl.message(
      'Please double-check one last time!\nThis action cannot be undone.',
      name: 'delete_confirm_message',
      desc: '',
      args: [],
    );
  }

  /// `Account sync active`
  String get accountSyncActive {
    return Intl.message(
      'Account sync active',
      name: 'accountSyncActive',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message('Unknown', name: 'unknown', desc: '', args: []);
  }

  /// `No more photos to delete`
  String get confirmnoMorePhotosToDelete {
    return Intl.message(
      'No more photos to delete',
      name: 'confirmnoMorePhotosToDelete',
      desc: '',
      args: [],
    );
  }

  /// `Live Photos`
  String get livePhotos {
    return Intl.message('Live Photos', name: 'livePhotos', desc: '', args: []);
  }

  /// `Live Photos are animated photos that can play short videos. Clean them up to free up storage.`
  String get livePhotosDescription {
    return Intl.message(
      'Live Photos are animated photos that can play short videos. Clean them up to free up storage.',
      name: 'livePhotosDescription',
      desc: '',
      args: [],
    );
  }

  /// `Blurry Photos`
  String get blurryPhotos {
    return Intl.message(
      'Blurry Photos',
      name: 'blurryPhotos',
      desc: '',
      args: [],
    );
  }

  /// `Detect and clean out photos that are blurry or have motion blur.`
  String get blurryPhotosDescription {
    return Intl.message(
      'Detect and clean out photos that are blurry or have motion blur.',
      name: 'blurryPhotosDescription',
      desc: '',
      args: [],
    );
  }

  /// `Potential motion blur detected`
  String get motionBlurDetected {
    return Intl.message(
      'Potential motion blur detected',
      name: 'motionBlurDetected',
      desc: '',
      args: [],
    );
  }

  /// `Blur Score: {score}`
  String blurScore(Object score) {
    return Intl.message(
      'Blur Score: $score',
      name: 'blurScore',
      desc: '',
      args: [score],
    );
  }

  /// `Images`
  String get images {
    return Intl.message('Images', name: 'images', desc: '', args: []);
  }

  /// `Images are photos that are not animated. Clean them up to free up storage.`
  String get imagesDescription {
    return Intl.message(
      'Images are photos that are not animated. Clean them up to free up storage.',
      name: 'imagesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Videos`
  String get videos {
    return Intl.message('Videos', name: 'videos', desc: '', args: []);
  }

  /// `Videos are animated photos that can play short videos. Clean them up to free up storage.`
  String get videosDescription {
    return Intl.message(
      'Videos are animated photos that can play short videos. Clean them up to free up storage.',
      name: 'videosDescription',
      desc: '',
      args: [],
    );
  }

  /// `Screenshots`
  String get screenshots {
    return Intl.message('Screenshots', name: 'screenshots', desc: '', args: []);
  }

  /// `Screenshots are photos that are not animated. Clean them up to free up storage.`
  String get screenshotsDescription {
    return Intl.message(
      'Screenshots are photos that are not animated. Clean them up to free up storage.',
      name: 'screenshotsDescription',
      desc: '',
      args: [],
    );
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

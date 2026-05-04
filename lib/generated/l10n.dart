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

  /// `Photo Duplicate Cleaner`
  String get appDescription {
    return Intl.message(
      'Photo Duplicate Cleaner',
      name: 'appDescription',
      desc: '',
      args: [],
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

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Awesome!`
  String get awesome {
    return Intl.message('Awesome!', name: 'awesome', desc: '', args: []);
  }

  /// `Got it`
  String get done {
    return Intl.message('Got it', name: 'done', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Or`
  String get or {
    return Intl.message('Or', name: 'or', desc: '', args: []);
  }

  /// `Unknown`
  String get unknown {
    return Intl.message('Unknown', name: 'unknown', desc: '', args: []);
  }

  /// `files`
  String get files {
    return Intl.message('files', name: 'files', desc: '', args: []);
  }

  /// `file`
  String get file {
    return Intl.message('file', name: 'file', desc: '', args: []);
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

  /// `Scanning device...`
  String get scanningDevice {
    return Intl.message(
      'Scanning device...',
      name: 'scanningDevice',
      desc: '',
      args: [],
    );
  }

  /// `Scanning document...`
  String get scanningDocument {
    return Intl.message(
      'Scanning document...',
      name: 'scanningDocument',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get tabScan {
    return Intl.message('Scan', name: 'tabScan', desc: '', args: []);
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

  /// `Scan results`
  String get scanResults {
    return Intl.message(
      'Scan results',
      name: 'scanResults',
      desc: '',
      args: [],
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

  /// `Calculating...`
  String get calculatingProgress {
    return Intl.message(
      'Calculating...',
      name: 'calculatingProgress',
      desc: '',
      args: [],
    );
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

  /// `Sort`
  String get sort {
    return Intl.message('Sort', name: 'sort', desc: '', args: []);
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

  /// `Successfully cleaned {num} {unit}`
  String cleanedSpaceSuccess(Object num, Object unit) {
    return Intl.message(
      'Successfully cleaned $num $unit',
      name: 'cleanedSpaceSuccess',
      desc: '',
      args: [num, unit],
    );
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

  /// `Cleaned`
  String get cleaned {
    return Intl.message('Cleaned', name: 'cleaned', desc: '', args: []);
  }

  /// `Streak`
  String get streak {
    return Intl.message('Streak', name: 'streak', desc: '', args: []);
  }

  /// `Days`
  String get days {
    return Intl.message('Days', name: 'days', desc: '', args: []);
  }

  /// `Blurry Deleted`
  String get blurryDeleted {
    return Intl.message(
      'Blurry Deleted',
      name: 'blurryDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Duplicates`
  String get duplicates {
    return Intl.message('Duplicates', name: 'duplicates', desc: '', args: []);
  }

  /// `Badges`
  String get badges {
    return Intl.message('Badges', name: 'badges', desc: '', args: []);
  }

  /// `All Badges`
  String get allBadges {
    return Intl.message('All Badges', name: 'allBadges', desc: '', args: []);
  }

  /// `Activity`
  String get activity {
    return Intl.message('Activity', name: 'activity', desc: '', args: []);
  }

  /// `Progress`
  String get progress {
    return Intl.message('Progress', name: 'progress', desc: '', args: []);
  }

  /// `Stats`
  String get stats {
    return Intl.message('Stats', name: 'stats', desc: '', args: []);
  }

  /// `Streaks`
  String get streaks {
    return Intl.message('Streaks', name: 'streaks', desc: '', args: []);
  }

  /// `Items Deleted`
  String get itemsDeleted {
    return Intl.message(
      'Items Deleted',
      name: 'itemsDeleted',
      desc: '',
      args: [],
    );
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

  /// `Cleaning Activity`
  String get activityDetailTitle {
    return Intl.message(
      'Cleaning Activity',
      name: 'activityDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Contribution graph`
  String get contributionGraph {
    return Intl.message(
      'Contribution graph',
      name: 'contributionGraph',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `No cleaning activity yet`
  String get noActivity {
    return Intl.message(
      'No cleaning activity yet',
      name: 'noActivity',
      desc: '',
      args: [],
    );
  }

  /// `Deleted {count} items`
  String deletedItemsCount(Object count) {
    return Intl.message(
      'Deleted $count items',
      name: 'deletedItemsCount',
      desc: '',
      args: [count],
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

  /// `New Badge!`
  String get congratsBadgeTitle {
    return Intl.message(
      'New Badge!',
      name: 'congratsBadgeTitle',
      desc: '',
      args: [],
    );
  }

  /// `You just earned the "{badgeName}" badge!`
  String congratsBadgeMessage(Object badgeName) {
    return Intl.message(
      'You just earned the "$badgeName" badge!',
      name: 'congratsBadgeMessage',
      desc: '',
      args: [badgeName],
    );
  }

  /// `You just earned {count} new badges!`
  String congratsMultipleBadgesMessage(Object count) {
    return Intl.message(
      'You just earned $count new badges!',
      name: 'congratsMultipleBadgesMessage',
      desc: '',
      args: [count],
    );
  }

  /// `View full history`
  String get viewFullHistory {
    return Intl.message(
      'View full history',
      name: 'viewFullHistory',
      desc: '',
      args: [],
    );
  }

  /// `Less`
  String get less {
    return Intl.message('Less', name: 'less', desc: '', args: []);
  }

  /// `More`
  String get more {
    return Intl.message('More', name: 'more', desc: '', args: []);
  }

  /// `Mon`
  String get mon {
    return Intl.message('Mon', name: 'mon', desc: '', args: []);
  }

  /// `Tue`
  String get tue {
    return Intl.message('Tue', name: 'tue', desc: '', args: []);
  }

  /// `Wed`
  String get wed {
    return Intl.message('Wed', name: 'wed', desc: '', args: []);
  }

  /// `Thu`
  String get thu {
    return Intl.message('Thu', name: 'thu', desc: '', args: []);
  }

  /// `Fri`
  String get fri {
    return Intl.message('Fri', name: 'fri', desc: '', args: []);
  }

  /// `Sat`
  String get sat {
    return Intl.message('Sat', name: 'sat', desc: '', args: []);
  }

  /// `Sun`
  String get sun {
    return Intl.message('Sun', name: 'sun', desc: '', args: []);
  }

  /// `No badges earned yet`
  String get noBadgesEarnedYet {
    return Intl.message(
      'No badges earned yet',
      name: 'noBadgesEarnedYet',
      desc: '',
      args: [],
    );
  }

  /// `View All Badges`
  String get viewAllBadges {
    return Intl.message(
      'View All Badges',
      name: 'viewAllBadges',
      desc: '',
      args: [],
    );
  }

  /// `Newbie Cleaner`
  String get badgeNewbieName {
    return Intl.message(
      'Newbie Cleaner',
      name: 'badgeNewbieName',
      desc: '',
      args: [],
    );
  }

  /// `Delete your first photo and start the journey to free your storage.`
  String get badgeNewbieDesc {
    return Intl.message(
      'Delete your first photo and start the journey to free your storage.',
      name: 'badgeNewbieDesc',
      desc: '',
      args: [],
    );
  }

  /// `First Clean`
  String get badgeFirstCleanName {
    return Intl.message(
      'First Clean',
      name: 'badgeFirstCleanName',
      desc: '',
      args: [],
    );
  }

  /// `Delete your very first photos.`
  String get badgeFirstCleanDesc {
    return Intl.message(
      'Delete your very first photos.',
      name: 'badgeFirstCleanDesc',
      desc: '',
      args: [],
    );
  }

  /// `Apprentice Cleaner`
  String get badgeCleaner10Name {
    return Intl.message(
      'Apprentice Cleaner',
      name: 'badgeCleaner10Name',
      desc: '',
      args: [],
    );
  }

  /// `Delete a total of 10 photos.`
  String get badgeCleaner10Desc {
    return Intl.message(
      'Delete a total of 10 photos.',
      name: 'badgeCleaner10Desc',
      desc: '',
      args: [],
    );
  }

  /// `Expert Cleaner`
  String get badgeCleaner100Name {
    return Intl.message(
      'Expert Cleaner',
      name: 'badgeCleaner100Name',
      desc: '',
      args: [],
    );
  }

  /// `Delete a total of 100 photos.`
  String get badgeCleaner100Desc {
    return Intl.message(
      'Delete a total of 100 photos.',
      name: 'badgeCleaner100Desc',
      desc: '',
      args: [],
    );
  }

  /// `Photo Shredder`
  String get badgeCleaner1000Name {
    return Intl.message(
      'Photo Shredder',
      name: 'badgeCleaner1000Name',
      desc: '',
      args: [],
    );
  }

  /// `Delete a total of 1000 photos.`
  String get badgeCleaner1000Desc {
    return Intl.message(
      'Delete a total of 1000 photos.',
      name: 'badgeCleaner1000Desc',
      desc: '',
      args: [],
    );
  }

  /// `Blur Hunter`
  String get badgeBlurry10Name {
    return Intl.message(
      'Blur Hunter',
      name: 'badgeBlurry10Name',
      desc: '',
      args: [],
    );
  }

  /// `Delete 10 blurry photos.`
  String get badgeBlurry10Desc {
    return Intl.message(
      'Delete 10 blurry photos.',
      name: 'badgeBlurry10Desc',
      desc: '',
      args: [],
    );
  }

  /// `Blur Killer`
  String get badgeBlurryKillerName {
    return Intl.message(
      'Blur Killer',
      name: 'badgeBlurryKillerName',
      desc: '',
      args: [],
    );
  }

  /// `Delete 50 blurry photos.`
  String get badgeBlurryKillerDesc {
    return Intl.message(
      'Delete 50 blurry photos.',
      name: 'badgeBlurryKillerDesc',
      desc: '',
      args: [],
    );
  }

  /// `Blur Destroyer`
  String get badgeBlurry200Name {
    return Intl.message(
      'Blur Destroyer',
      name: 'badgeBlurry200Name',
      desc: '',
      args: [],
    );
  }

  /// `Delete 200 blurry photos.`
  String get badgeBlurry200Desc {
    return Intl.message(
      'Delete 200 blurry photos.',
      name: 'badgeBlurry200Desc',
      desc: '',
      args: [],
    );
  }

  /// `Duplicate Hunter`
  String get badgeDuplicate20Name {
    return Intl.message(
      'Duplicate Hunter',
      name: 'badgeDuplicate20Name',
      desc: '',
      args: [],
    );
  }

  /// `Delete 20 duplicate photos.`
  String get badgeDuplicate20Desc {
    return Intl.message(
      'Delete 20 duplicate photos.',
      name: 'badgeDuplicate20Desc',
      desc: '',
      args: [],
    );
  }

  /// `Duplicate Master`
  String get badgeDuplicate100Name {
    return Intl.message(
      'Duplicate Master',
      name: 'badgeDuplicate100Name',
      desc: '',
      args: [],
    );
  }

  /// `Delete 100 duplicate photos.`
  String get badgeDuplicate100Desc {
    return Intl.message(
      'Delete 100 duplicate photos.',
      name: 'badgeDuplicate100Desc',
      desc: '',
      args: [],
    );
  }

  /// `Storage Novice`
  String get badgeFreed100mbName {
    return Intl.message(
      'Storage Novice',
      name: 'badgeFreed100mbName',
      desc: '',
      args: [],
    );
  }

  /// `Delete a total of 200 photos.`
  String get badgeFreed100mbDesc {
    return Intl.message(
      'Delete a total of 200 photos.',
      name: 'badgeFreed100mbDesc',
      desc: '',
      args: [],
    );
  }

  /// `Cleaning Master`
  String get badgeGigaKingName {
    return Intl.message(
      'Cleaning Master',
      name: 'badgeGigaKingName',
      desc: '',
      args: [],
    );
  }

  /// `Delete a total of 500 photos.`
  String get badgeGigaKingDesc {
    return Intl.message(
      'Delete a total of 500 photos.',
      name: 'badgeGigaKingDesc',
      desc: '',
      args: [],
    );
  }

  /// `Storage Hero`
  String get badgeFreed5gbName {
    return Intl.message(
      'Storage Hero',
      name: 'badgeFreed5gbName',
      desc: '',
      args: [],
    );
  }

  /// `Delete a total of 2000 photos.`
  String get badgeFreed5gbDesc {
    return Intl.message(
      'Delete a total of 2000 photos.',
      name: 'badgeFreed5gbDesc',
      desc: '',
      args: [],
    );
  }

  /// `Disk Legend`
  String get badgeFreed10gbName {
    return Intl.message(
      'Disk Legend',
      name: 'badgeFreed10gbName',
      desc: '',
      args: [],
    );
  }

  /// `Delete a total of 5000 photos.`
  String get badgeFreed10gbDesc {
    return Intl.message(
      'Delete a total of 5000 photos.',
      name: 'badgeFreed10gbDesc',
      desc: '',
      args: [],
    );
  }

  /// `Dedicated`
  String get badgeStreak3Name {
    return Intl.message(
      'Dedicated',
      name: 'badgeStreak3Name',
      desc: '',
      args: [],
    );
  }

  /// `Clean up for 3 consecutive days.`
  String get badgeStreak3Desc {
    return Intl.message(
      'Clean up for 3 consecutive days.',
      name: 'badgeStreak3Desc',
      desc: '',
      args: [],
    );
  }

  /// `Never Give Up`
  String get badgeStreak7Name {
    return Intl.message(
      'Never Give Up',
      name: 'badgeStreak7Name',
      desc: '',
      args: [],
    );
  }

  /// `Clean up for 7 consecutive days.`
  String get badgeStreak7Desc {
    return Intl.message(
      'Clean up for 7 consecutive days.',
      name: 'badgeStreak7Desc',
      desc: '',
      args: [],
    );
  }

  /// `Speed Cleaner`
  String get badgeSpeedCleanName {
    return Intl.message(
      'Speed Cleaner',
      name: 'badgeSpeedCleanName',
      desc: '',
      args: [],
    );
  }

  /// `Delete 50 photos in a single session.`
  String get badgeSpeedCleanDesc {
    return Intl.message(
      'Delete 50 photos in a single session.',
      name: 'badgeSpeedCleanDesc',
      desc: '',
      args: [],
    );
  }

  /// `AI Assistant`
  String get badgeAiCleanerName {
    return Intl.message(
      'AI Assistant',
      name: 'badgeAiCleanerName',
      desc: '',
      args: [],
    );
  }

  /// `Use the automatic cleanup feature.`
  String get badgeAiCleanerDesc {
    return Intl.message(
      'Use the automatic cleanup feature.',
      name: 'badgeAiCleanerDesc',
      desc: '',
      args: [],
    );
  }

  /// `Perfectionist`
  String get badgePerfectionistName {
    return Intl.message(
      'Perfectionist',
      name: 'badgePerfectionistName',
      desc: '',
      args: [],
    );
  }

  /// `Delete over 80% of blurry photos on your device.`
  String get badgePerfectionistDesc {
    return Intl.message(
      'Delete over 80% of blurry photos on your device.',
      name: 'badgePerfectionistDesc',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Settings`
  String get tabSettings {
    return Intl.message('Settings', name: 'tabSettings', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
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

  /// `Background Style`
  String get backgroundStyle {
    return Intl.message(
      'Background Style',
      name: 'backgroundStyle',
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

  /// `Scan Limit`
  String get scanLimit {
    return Intl.message('Scan Limit', name: 'scanLimit', desc: '', args: []);
  }

  /// `The maximum number of photos to scan.`
  String get scanLimitDescription {
    return Intl.message(
      'The maximum number of photos to scan.',
      name: 'scanLimitDescription',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get scanLimitAll {
    return Intl.message('All', name: 'scanLimitAll', desc: '', args: []);
  }

  /// `Scanning all photos may take a long time and use more battery.`
  String get scanLimitWarning {
    return Intl.message(
      'Scanning all photos may take a long time and use more battery.',
      name: 'scanLimitWarning',
      desc: '',
      args: [],
    );
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

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Do not have an account? Register`
  String get noAccountRegister {
    return Intl.message(
      'Do not have an account? Register',
      name: 'noAccountRegister',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPasswordQuestion {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPasswordQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Create an Account`
  String get createAccount {
    return Intl.message(
      'Create an Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Login`
  String get alreadyHaveAccountLogin {
    return Intl.message(
      'Already have an account? Login',
      name: 'alreadyHaveAccountLogin',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPasswordTitle {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reset link sent to your email!`
  String get resetLinkSent {
    return Intl.message(
      'Reset link sent to your email!',
      name: 'resetLinkSent',
      desc: '',
      args: [],
    );
  }

  /// `Failed to send reset link`
  String get failedToSendResetLink {
    return Intl.message(
      'Failed to send reset link',
      name: 'failedToSendResetLink',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address and we will send you a link to reset your password.`
  String get forgotPasswordDescription {
    return Intl.message(
      'Enter your email address and we will send you a link to reset your password.',
      name: 'forgotPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Link`
  String get sendResetLink {
    return Intl.message(
      'Send Reset Link',
      name: 'sendResetLink',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Unknown User`
  String get unknownUser {
    return Intl.message(
      'Unknown User',
      name: 'unknownUser',
      desc: '',
      args: [],
    );
  }

  /// `No email provided`
  String get noEmailProvided {
    return Intl.message(
      'No email provided',
      name: 'noEmailProvided',
      desc: '',
      args: [],
    );
  }

  /// `Login successful`
  String get loginSuccess {
    return Intl.message(
      'Login successful',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful`
  String get registerSuccess {
    return Intl.message(
      'Registration successful',
      name: 'registerSuccess',
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

  /// `Confirm delete`
  String get confirmDelete {
    return Intl.message(
      'Confirm delete',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
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

  /// `No more photos to delete`
  String get confirmnoMorePhotosToDelete {
    return Intl.message(
      'No more photos to delete',
      name: 'confirmnoMorePhotosToDelete',
      desc: '',
      args: [],
    );
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

  /// `Remove GPS`
  String get removeGPS {
    return Intl.message('Remove GPS', name: 'removeGPS', desc: '', args: []);
  }

  /// `Remove GPS information from photos.`
  String get removeGPSDescription {
    return Intl.message(
      'Remove GPS information from photos.',
      name: 'removeGPSDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add Watermark`
  String get addWaterMark {
    return Intl.message(
      'Add Watermark',
      name: 'addWaterMark',
      desc: '',
      args: [],
    );
  }

  /// `Add watermark to photos.`
  String get addWaterMarkDescription {
    return Intl.message(
      'Add watermark to photos.',
      name: 'addWaterMarkDescription',
      desc: '',
      args: [],
    );
  }

  /// `Blur Face`
  String get blurFace {
    return Intl.message('Blur Face', name: 'blurFace', desc: '', args: []);
  }

  /// `Blur face in photos.`
  String get blurFaceDescription {
    return Intl.message(
      'Blur face in photos.',
      name: 'blurFaceDescription',
      desc: '',
      args: [],
    );
  }

  /// `Watermark Text`
  String get watermarkText {
    return Intl.message(
      'Watermark Text',
      name: 'watermarkText',
      desc: '',
      args: [],
    );
  }

  /// `Select Template`
  String get selectTemplate {
    return Intl.message(
      'Select Template',
      name: 'selectTemplate',
      desc: '',
      args: [],
    );
  }

  /// `Replace Original`
  String get replaceOriginal {
    return Intl.message(
      'Replace Original',
      name: 'replaceOriginal',
      desc: '',
      args: [],
    );
  }

  /// `Create New Image`
  String get createNewImage {
    return Intl.message(
      'Create New Image',
      name: 'createNewImage',
      desc: '',
      args: [],
    );
  }

  /// `Saving...`
  String get saving {
    return Intl.message('Saving...', name: 'saving', desc: '', args: []);
  }

  /// `Image saved successfully!`
  String get imageSaved {
    return Intl.message(
      'Image saved successfully!',
      name: 'imageSaved',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Enter watermark text`
  String get enterWatermarkText {
    return Intl.message(
      'Enter watermark text',
      name: 'enterWatermarkText',
      desc: '',
      args: [],
    );
  }

  /// `Standard`
  String get template_standard {
    return Intl.message(
      'Standard',
      name: 'template_standard',
      desc: '',
      args: [],
    );
  }

  /// `Outline`
  String get template_outline {
    return Intl.message(
      'Outline',
      name: 'template_outline',
      desc: '',
      args: [],
    );
  }

  /// `Glass`
  String get template_glass {
    return Intl.message('Glass', name: 'template_glass', desc: '', args: []);
  }

  /// `Copyright`
  String get template_copyright {
    return Intl.message(
      'Copyright',
      name: 'template_copyright',
      desc: '',
      args: [],
    );
  }

  /// `Minimal`
  String get template_minimal {
    return Intl.message(
      'Minimal',
      name: 'template_minimal',
      desc: '',
      args: [],
    );
  }

  /// `Document Detection`
  String get document {
    return Intl.message(
      'Document Detection',
      name: 'document',
      desc: '',
      args: [],
    );
  }

  /// `Identify and manage images containing text.`
  String get documentDescription {
    return Intl.message(
      'Identify and manage images containing text.',
      name: 'documentDescription',
      desc: '',
      args: [],
    );
  }

  /// `No images with text found.`
  String get noDocumentsFound {
    return Intl.message(
      'No images with text found.',
      name: 'noDocumentsFound',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Edit image`
  String get editDescription {
    return Intl.message(
      'Edit image',
      name: 'editDescription',
      desc: '',
      args: [],
    );
  }

  /// `Paint`
  String get paint {
    return Intl.message('Paint', name: 'paint', desc: '', args: []);
  }

  /// `Text`
  String get text {
    return Intl.message('Text', name: 'text', desc: '', args: []);
  }

  /// `Crop`
  String get crop {
    return Intl.message('Crop', name: 'crop', desc: '', args: []);
  }

  /// `Filter`
  String get filter {
    return Intl.message('Filter', name: 'filter', desc: '', args: []);
  }

  /// `Tune`
  String get tune {
    return Intl.message('Tune', name: 'tune', desc: '', args: []);
  }

  /// `Blur`
  String get blur {
    return Intl.message('Blur', name: 'blur', desc: '', args: []);
  }

  /// `Blur`
  String get effectBlur {
    return Intl.message('Blur', name: 'effectBlur', desc: '', args: []);
  }

  /// `Pixelate`
  String get effectPixelate {
    return Intl.message('Pixelate', name: 'effectPixelate', desc: '', args: []);
  }

  /// `Solid Color`
  String get effectSolid {
    return Intl.message('Solid Color', name: 'effectSolid', desc: '', args: []);
  }

  /// `Emoji`
  String get effectEmoji {
    return Intl.message('Emoji', name: 'effectEmoji', desc: '', args: []);
  }

  /// `Please enter watermark text`
  String get pleaseEnterWatermarkText {
    return Intl.message(
      'Please enter watermark text',
      name: 'pleaseEnterWatermarkText',
      desc: '',
      args: [],
    );
  }

  /// `Could not decode image`
  String get couldNotDecodeImage {
    return Intl.message(
      'Could not decode image',
      name: 'couldNotDecodeImage',
      desc: '',
      args: [],
    );
  }

  /// `Opacity`
  String get opacity {
    return Intl.message('Opacity', name: 'opacity', desc: '', args: []);
  }

  /// `Size`
  String get size {
    return Intl.message('Size', name: 'size', desc: '', args: []);
  }

  /// `Density`
  String get density {
    return Intl.message('Density', name: 'density', desc: '', args: []);
  }

  /// `Finish`
  String get finish {
    return Intl.message('Finish', name: 'finish', desc: '', args: []);
  }

  /// `Edit another photo`
  String get editAnotherPhoto {
    return Intl.message(
      'Edit another photo',
      name: 'editAnotherPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Pixelate`
  String get pixelate {
    return Intl.message('Pixelate', name: 'pixelate', desc: '', args: []);
  }

  /// `Solid`
  String get solid {
    return Intl.message('Solid', name: 'solid', desc: '', args: []);
  }

  /// `Emoji`
  String get emoji {
    return Intl.message('Emoji', name: 'emoji', desc: '', args: []);
  }

  /// `Failed to convert image`
  String get convertImageFailed {
    return Intl.message(
      'Failed to convert image',
      name: 'convertImageFailed',
      desc: '',
      args: [],
    );
  }

  /// `Glasses`
  String get glasses {
    return Intl.message('Glasses', name: 'glasses', desc: '', args: []);
  }

  /// `Face Mask`
  String get mask {
    return Intl.message('Face Mask', name: 'mask', desc: '', args: []);
  }

  /// `Eye Bar`
  String get eyeBar {
    return Intl.message('Eye Bar', name: 'eyeBar', desc: '', args: []);
  }

  /// `Intensity`
  String get intensity {
    return Intl.message('Intensity', name: 'intensity', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Select Emoji`
  String get selectEmoji {
    return Intl.message(
      'Select Emoji',
      name: 'selectEmoji',
      desc: '',
      args: [],
    );
  }

  /// `Tap to change style`
  String get tapToChangeStyle {
    return Intl.message(
      'Tap to change style',
      name: 'tapToChangeStyle',
      desc: '',
      args: [],
    );
  }

  /// `Media Info`
  String get mediaInfo {
    return Intl.message('Media Info', name: 'mediaInfo', desc: '', args: []);
  }

  /// `Unable to play media`
  String get error_unable_to_play_media {
    return Intl.message(
      'Unable to play media',
      name: 'error_unable_to_play_media',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported media type`
  String get error_unsupported_media_type {
    return Intl.message(
      'Unsupported media type',
      name: 'error_unsupported_media_type',
      desc: '',
      args: [],
    );
  }

  /// `No faces detected in this photo.`
  String get noFacesDetected {
    return Intl.message(
      'No faces detected in this photo.',
      name: 'noFacesDetected',
      desc: '',
      args: [],
    );
  }

  /// `No images with location data found.`
  String get noPhotosWithGPSFound {
    return Intl.message(
      'No images with location data found.',
      name: 'noPhotosWithGPSFound',
      desc: '',
      args: [],
    );
  }

  /// `GPS location data removed and saved as a new copy.`
  String get gpsRemovedSuccess {
    return Intl.message(
      'GPS location data removed and saved as a new copy.',
      name: 'gpsRemovedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message('About Us', name: 'aboutUs', desc: '', args: []);
  }

  /// `Version {version}`
  String appVersion(Object version) {
    return Intl.message(
      'Version $version',
      name: 'appVersion',
      desc: '',
      args: [version],
    );
  }

  /// `Twinfix is a powerful tool designed to help you organize and clean up your photo gallery with ease using AI.`
  String get aboutDescription {
    return Intl.message(
      'Twinfix is a powerful tool designed to help you organize and clean up your photo gallery with ease using AI.',
      name: 'aboutDescription',
      desc: '',
      args: [],
    );
  }

  /// `Key Features`
  String get featuresTitle {
    return Intl.message(
      'Key Features',
      name: 'featuresTitle',
      desc: '',
      args: [],
    );
  }

  /// `Fast Scanning`
  String get featureScan {
    return Intl.message(
      'Fast Scanning',
      name: 'featureScan',
      desc: '',
      args: [],
    );
  }

  /// `Efficient Cleaning`
  String get featureClean {
    return Intl.message(
      'Efficient Cleaning',
      name: 'featureClean',
      desc: '',
      args: [],
    );
  }

  /// `Friendly Mascot Support`
  String get featureMascot {
    return Intl.message(
      'Friendly Mascot Support',
      name: 'featureMascot',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `Website`
  String get website {
    return Intl.message('Website', name: 'website', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsOfService {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// `Unlock Premium`
  String get paywallTitle {
    return Intl.message(
      'Unlock Premium',
      name: 'paywallTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy all professional features without limits.`
  String get paywallSubtitle {
    return Intl.message(
      'Enjoy all professional features without limits.',
      name: 'paywallSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `No advertisements`
  String get premiumFeatureNoAds {
    return Intl.message(
      'No advertisements',
      name: 'premiumFeatureNoAds',
      desc: '',
      args: [],
    );
  }

  /// `Unlock all AI tools`
  String get premiumFeatureAiTools {
    return Intl.message(
      'Unlock all AI tools',
      name: 'premiumFeatureAiTools',
      desc: '',
      args: [],
    );
  }

  /// `High-quality image editing`
  String get premiumFeatureHighQuality {
    return Intl.message(
      'High-quality image editing',
      name: 'premiumFeatureHighQuality',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get packageFreeTitle {
    return Intl.message('Free', name: 'packageFreeTitle', desc: '', args: []);
  }

  /// `Free`
  String get packageFreePrice {
    return Intl.message('Free', name: 'packageFreePrice', desc: '', args: []);
  }

  /// `Ad-supported version with limited features`
  String get packageFreeDescription {
    return Intl.message(
      'Ad-supported version with limited features',
      name: 'packageFreeDescription',
      desc: '',
      args: [],
    );
  }

  /// `1 Month`
  String get packageMonthlyTitle {
    return Intl.message(
      '1 Month',
      name: 'packageMonthlyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Monthly subscription. Cancel anytime.`
  String get packageMonthlyDescription {
    return Intl.message(
      'Monthly subscription. Cancel anytime.',
      name: 'packageMonthlyDescription',
      desc: '',
      args: [],
    );
  }

  /// `Lifetime`
  String get packageLifetimeTitle {
    return Intl.message(
      'Lifetime',
      name: 'packageLifetimeTitle',
      desc: '',
      args: [],
    );
  }

  /// `One-time purchase, keep forever.`
  String get packageLifetimeDescription {
    return Intl.message(
      'One-time purchase, keep forever.',
      name: 'packageLifetimeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Restore Purchases`
  String get restorePurchases {
    return Intl.message(
      'Restore Purchases',
      name: 'restorePurchases',
      desc: '',
      args: [],
    );
  }

  /// `MOST POPULAR`
  String get popular {
    return Intl.message('MOST POPULAR', name: 'popular', desc: '', args: []);
  }

  /// `Premium upgrade successful!`
  String get purchaseSuccess {
    return Intl.message(
      'Premium upgrade successful!',
      name: 'purchaseSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Could not connect to store.`
  String get purchaseErrorStoreConnection {
    return Intl.message(
      'Could not connect to store.',
      name: 'purchaseErrorStoreConnection',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade to Premium`
  String get upgradeToPremium {
    return Intl.message(
      'Upgrade to Premium',
      name: 'upgradeToPremium',
      desc: '',
      args: [],
    );
  }

  /// `Premium Plan`
  String get premiumPlan {
    return Intl.message(
      'Premium Plan',
      name: 'premiumPlan',
      desc: '',
      args: [],
    );
  }

  /// `Free Plan`
  String get freePlan {
    return Intl.message('Free Plan', name: 'freePlan', desc: '', args: []);
  }

  /// `Welcome to Premium`
  String get paywallWelcomeTitle {
    return Intl.message(
      'Welcome to Premium',
      name: 'paywallWelcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Unlock the full potential of your gallery with AI-powered tools and an ad-free experience.`
  String get paywallWelcomeSubtitle {
    return Intl.message(
      'Unlock the full potential of your gallery with AI-powered tools and an ad-free experience.',
      name: 'paywallWelcomeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Free Version`
  String get continueWithFreeVersion {
    return Intl.message(
      'Continue with Free Version',
      name: 'continueWithFreeVersion',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get signInWithGoogle {
    return Intl.message(
      'Sign in with Google',
      name: 'signInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Permission Required`
  String get permissionRequired {
    return Intl.message(
      'Permission Required',
      name: 'permissionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Twinfix needs access to your photo library to scan and clean duplicate photos.`
  String get permissionDescription {
    return Intl.message(
      'Twinfix needs access to your photo library to scan and clean duplicate photos.',
      name: 'permissionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Grant Permission`
  String get grantPermission {
    return Intl.message(
      'Grant Permission',
      name: 'grantPermission',
      desc: '',
      args: [],
    );
  }

  /// `Open Settings`
  String get openSettings {
    return Intl.message(
      'Open Settings',
      name: 'openSettings',
      desc: '',
      args: [],
    );
  }

  /// `Name is required`
  String get nameRequired {
    return Intl.message(
      'Name is required',
      name: 'nameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Name must be at least 2 characters`
  String get nameLength {
    return Intl.message(
      'Name must be at least 2 characters',
      name: 'nameLength',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailRequired {
    return Intl.message(
      'Email is required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format`
  String get emailInvalid {
    return Intl.message(
      'Invalid email format',
      name: 'emailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters, include uppercase, lowercase, number and special character`
  String get passwordLength {
    return Intl.message(
      'Password must be at least 8 characters, include uppercase, lowercase, number and special character',
      name: 'passwordLength',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password is required`
  String get confirmPasswordRequired {
    return Intl.message(
      'Confirm password is required',
      name: 'confirmPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Login failed. Please try again.`
  String get loginFailureMessage {
    return Intl.message(
      'Login failed. Please try again.',
      name: 'loginFailureMessage',
      desc: '',
      args: [],
    );
  }

  /// `Could not restore purchases or you don't have a subscription.`
  String get restoreFailureMessage {
    return Intl.message(
      'Could not restore purchases or you don\'t have a subscription.',
      name: 'restoreFailureMessage',
      desc: '',
      args: [],
    );
  }

  /// `Purchase failed or was cancelled.`
  String get purchaseFailureMessage {
    return Intl.message(
      'Purchase failed or was cancelled.',
      name: 'purchaseFailureMessage',
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

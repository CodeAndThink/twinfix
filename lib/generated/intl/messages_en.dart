// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file: strict_top_level_inference,unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) => "You unlocked ${count} badges";

  static String m1(count, total) =>
      "You unlocked ${count} out of ${total} badges";

  static String m2(count) => "Total ${count} badges earned";

  static String m3(count, total) =>
      "You have unlocked ${count} badges out of ${total} total badges";

  static String m4(count) => "You have ${count} badges left to unlock";

  static String m5(count, total) =>
      "You have ${count} badges left to unlock out of ${total} total badges";

  static String m6(count) => "Total ${count} badges not yet earned";

  static String m7(count, total) =>
      "You have ${count} badges remaining out of ${total} total badges";

  static String m8(count) => "Total ${count} badges";

  static String m9(count, total) =>
      "Total ${count} badges out of ${total} total badges";

  static String m10(count) =>
      "Are you sure you want to delete ${count} photos?";

  static String m11(count) =>
      "Are you sure you want to delete ${count} duplicate photos?";

  static String m12(count) => "Delete (${count})";

  static String m13(count) => "Detected ${count} duplicate groups";

  static String m14(count) => "Detected ${count} duplicate photos";

  static String m15(message) => "Error: ${message}";

  static String m16(index, count) => "Group ${index} (${count} photos)";

  static String m17(level) => "Level ${level}";

  static String m18(id) => "ID: ${id}";

  static String m19(percent) =>
      "Storage almost full (${percent}%), clean up now!";

  static String m20(days) => "${days} Days Streak";

  static String m21(percent) => "To next level (${percent})";

  static String m22(count) => "${count} photos";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "achievements": MessageLookupByLibrary.simpleMessage("Achievements"),
    "achievementsDescription": MessageLookupByLibrary.simpleMessage(
      "Collect all badges to become a cleaning master!",
    ),
    "achievementsEarned": m0,
    "achievementsEarnedDescription": m1,
    "achievementsEarnedTotal": m2,
    "achievementsEarnedTotalDescription": m3,
    "achievementsNotEarned": m4,
    "achievementsNotEarnedDescription": m5,
    "achievementsNotEarnedTotal": m6,
    "achievementsNotEarnedTotalDescription": m7,
    "achievementsTotal": m8,
    "achievementsTotalDescription": m9,
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "Photo Duplicate Cleaner",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("Twinfix"),
    "appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "backgroundStyle": MessageLookupByLibrary.simpleMessage("Background Style"),
    "badges": MessageLookupByLibrary.simpleMessage("Badges"),
    "bgNature1": MessageLookupByLibrary.simpleMessage("Dragon Boat"),
    "bgNature2": MessageLookupByLibrary.simpleMessage("Forest Lake"),
    "bgNature3": MessageLookupByLibrary.simpleMessage("Mountain"),
    "bgNature4": MessageLookupByLibrary.simpleMessage("Sunset"),
    "bgNone": MessageLookupByLibrary.simpleMessage("Clean"),
    "bgPremium": MessageLookupByLibrary.simpleMessage("Premium Abstract"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cleanedData": MessageLookupByLibrary.simpleMessage("Cleaned Data"),
    "clearSelection": MessageLookupByLibrary.simpleMessage("Clear selection"),
    "confirmDelete": MessageLookupByLibrary.simpleMessage("Confirm delete"),
    "confirmDeleteMessage": m10,
    "deepScan": MessageLookupByLibrary.simpleMessage("Deep Scan"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteDuplicates": MessageLookupByLibrary.simpleMessage(
      "Delete duplicate photos",
    ),
    "deleteDuplicatesMessage": m11,
    "deleteSelected": m12,
    "detectedDuplicateGroups": m13,
    "detectedDuplicates": m14,
    "deviceIsClean": MessageLookupByLibrary.simpleMessage(
      "Your device is very clean.",
    ),
    "earned": MessageLookupByLibrary.simpleMessage("Unlocked"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "error": m15,
    "galleryManager": MessageLookupByLibrary.simpleMessage("Gallery Manager"),
    "general": MessageLookupByLibrary.simpleMessage("General"),
    "groupIndex": m16,
    "howToEarn": MessageLookupByLibrary.simpleMessage("How to earn?"),
    "howToEarnDescription": MessageLookupByLibrary.simpleMessage(
      "You need to perform more system cleaning steps or invite friends to get this prestigious badge.",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "level": m17,
    "longPressToSelectAll": MessageLookupByLibrary.simpleMessage(
      "Long press to select all",
    ),
    "memoryWarning": MessageLookupByLibrary.simpleMessage(
      "Storage almost full!",
    ),
    "noDuplicatesFound": MessageLookupByLibrary.simpleMessage(
      "No duplicate photos found",
    ),
    "notEarned": MessageLookupByLibrary.simpleMessage("Requirements not met"),
    "onboardingDemoSwipeLeft": MessageLookupByLibrary.simpleMessage(
      "Swipe Left to Delete",
    ),
    "onboardingDemoSwipeRight": MessageLookupByLibrary.simpleMessage(
      "Swipe Right to Keep",
    ),
    "onboardingPrivacyMsg": MessageLookupByLibrary.simpleMessage(
      "All your photos are processed offline. Your data never leaves your device!",
    ),
    "onboardingStartScan": MessageLookupByLibrary.simpleMessage(
      "Start Scanning",
    ),
    "onboardingWelcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Welcome to Twinfix",
    ),
    "perfect": MessageLookupByLibrary.simpleMessage("Perfect!"),
    "photoId": m18,
    "quickScan": MessageLookupByLibrary.simpleMessage("Quick Scan"),
    "scanResults": MessageLookupByLibrary.simpleMessage("Scan results"),
    "scanningDevice": MessageLookupByLibrary.simpleMessage(
      "Scanning device...",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "storageAlmostFull": m19,
    "streakDays": m20,
    "swipeLeftToDeleteKeepRight": MessageLookupByLibrary.simpleMessage(
      "Swipe left to delete, keep right",
    ),
    "tabDashboard": MessageLookupByLibrary.simpleMessage("Achievements"),
    "tabScan": MessageLookupByLibrary.simpleMessage("Scan"),
    "tabSettings": MessageLookupByLibrary.simpleMessage("Settings"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "themeSystem": MessageLookupByLibrary.simpleMessage("System"),
    "toNextLevel": m21,
    "totalPhotos": m22,
    "vietnamese": MessageLookupByLibrary.simpleMessage("Vietnamese"),
  };
}

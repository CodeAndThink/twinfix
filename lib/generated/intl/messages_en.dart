// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
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

  static String m0(count) => "Are you sure you want to delete ${count} photos?";

  static String m1(count) =>
      "Are you sure you want to delete ${count} duplicate photos?";

  static String m2(count) => "Delete (${count})";

  static String m3(count) => "Detected ${count} duplicate groups";

  static String m4(count) => "Detected ${count} duplicate photos";

  static String m5(message) => "Error: ${message}";

  static String m6(index, count) => "Group ${index} (${count} photos)";

  static String m7(level) => "Level ${level}";

  static String m8(id) => "ID: ${id}";

  static String m9(percent) =>
      "Storage almost full (${percent}%), clean up now!";

  static String m10(days) => "${days} Days Streak";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appName": MessageLookupByLibrary.simpleMessage("Twinfix"),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "badges": MessageLookupByLibrary.simpleMessage("Badges"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cleanedData": MessageLookupByLibrary.simpleMessage("Cleaned Data"),
    "clearSelection": MessageLookupByLibrary.simpleMessage("Clear selection"),
    "confirmDelete": MessageLookupByLibrary.simpleMessage("Confirm delete"),
    "confirmDeleteMessage": m0,
    "deepScan": MessageLookupByLibrary.simpleMessage("Deep Scan"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteDuplicates": MessageLookupByLibrary.simpleMessage(
      "Delete duplicate photos",
    ),
    "deleteDuplicatesMessage": m1,
    "deleteSelected": m2,
    "detectedDuplicateGroups": m3,
    "detectedDuplicates": m4,
    "deviceIsClean": MessageLookupByLibrary.simpleMessage(
      "Your device is very clean.",
    ),
    "error": m5,
    "groupIndex": m6,
    "level": m7,
    "longPressToSelectAll": MessageLookupByLibrary.simpleMessage(
      "Long press to select all",
    ),
    "memoryWarning": MessageLookupByLibrary.simpleMessage(
      "Storage almost full!",
    ),
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
    "photoId": m8,
    "quickScan": MessageLookupByLibrary.simpleMessage("Quick Scan"),
    "scanningDevice": MessageLookupByLibrary.simpleMessage(
      "Scanning device...",
    ),
    "storageAlmostFull": m9,
    "streakDays": m10,
    "swipeLeftToDeleteKeepRight": MessageLookupByLibrary.simpleMessage(
      "Swipe left to delete, keep right",
    ),
    "tabDashboard": MessageLookupByLibrary.simpleMessage("Achievements"),
    "tabScan": MessageLookupByLibrary.simpleMessage("Scan"),
  };
}

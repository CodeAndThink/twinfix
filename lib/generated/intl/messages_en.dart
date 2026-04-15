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

  static String m10(size) => "Successfully cleaned ${size}";

  static String m11(count) =>
      "Are you sure you want to delete ${count} photos? They will be moved to the system trash. You may need to empty the trash to free up storage.";

  static String m12(count) =>
      "Are you sure you want to delete ${count} duplicate photos? They will be moved to the system trash.";

  static String m13(count) => "Delete (${count})";

  static String m14(count) => "Delete ${count} photos";

  static String m15(count) =>
      "Are you sure you want to delete ${count} photos? They will be moved to the system trash. You may need to empty the trash to free up storage.";

  static String m16(count) => "Deleted ${count} photos successfully";

  static String m17(count) => "Detected ${count} duplicate groups";

  static String m18(count) => "Detected ${count} duplicate photos";

  static String m19(message) => "Error: ${message}";

  static String m20(index, count) => "Group ${index} (${count} photos)";

  static String m21(level) => "Level ${level}";

  static String m22(email) => "Logged in as ${email}";

  static String m23(id) => "ID: ${id}";

  static String m24(percent) =>
      "Storage almost full (${percent}%), clean up now!";

  static String m25(days) => "${days} Days Streak";

  static String m26(percent) => "To next level (${percent})";

  static String m27(count) => "${count} photos";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "account": MessageLookupByLibrary.simpleMessage("Account"),
    "accountSyncActive": MessageLookupByLibrary.simpleMessage(
      "Account sync active",
    ),
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
    "calculatingProgress": MessageLookupByLibrary.simpleMessage(
      "Calculating...",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cleanedData": MessageLookupByLibrary.simpleMessage("Cleaned Data"),
    "cleanedSpaceSuccess": m10,
    "clearSelection": MessageLookupByLibrary.simpleMessage("Clear selection"),
    "confirmDelete": MessageLookupByLibrary.simpleMessage("Confirm delete"),
    "confirmDeleteMessage": m11,
    "dateAsc": MessageLookupByLibrary.simpleMessage("Date Ascending"),
    "dateDesc": MessageLookupByLibrary.simpleMessage("Date Descending"),
    "deepScan": MessageLookupByLibrary.simpleMessage("Deep Scan"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteDuplicates": MessageLookupByLibrary.simpleMessage(
      "Delete duplicate photos",
    ),
    "deleteDuplicatesMessage": m12,
    "deleteSelected": m13,
    "deleteSelectedPhotos": m14,
    "deleteSelectedPhotosMessage": m15,
    "deleteSuccess": m16,
    "delete_confirm_message": MessageLookupByLibrary.simpleMessage(
      "Please double-check one last time!\nThis action cannot be undone.",
    ),
    "detectedDuplicateGroups": m17,
    "detectedDuplicates": m18,
    "deviceIsClean": MessageLookupByLibrary.simpleMessage(
      "Your device is very clean.",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Got it"),
    "earned": MessageLookupByLibrary.simpleMessage("Unlocked"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "error": m19,
    "galleryManager": MessageLookupByLibrary.simpleMessage("Gallery Manager"),
    "general": MessageLookupByLibrary.simpleMessage("General"),
    "groupIndex": m20,
    "howToEarn": MessageLookupByLibrary.simpleMessage("How to earn?"),
    "howToEarnDescription": MessageLookupByLibrary.simpleMessage(
      "You need to perform more system cleaning steps or invite friends to get this prestigious badge.",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "level": m21,
    "loggedInAs": m22,
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginToSync": MessageLookupByLibrary.simpleMessage(
      "Log in to sync your progress across devices",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Log out"),
    "longPressToSelectAll": MessageLookupByLibrary.simpleMessage(
      "Long press to select all",
    ),
    "media_audio": MessageLookupByLibrary.simpleMessage("Audio"),
    "media_document": MessageLookupByLibrary.simpleMessage("Document"),
    "media_other": MessageLookupByLibrary.simpleMessage("Other"),
    "media_photo": MessageLookupByLibrary.simpleMessage("Photo"),
    "media_type_selection": MessageLookupByLibrary.simpleMessage(
      "Media Type Selection",
    ),
    "media_video": MessageLookupByLibrary.simpleMessage("Video"),
    "memoryWarning": MessageLookupByLibrary.simpleMessage(
      "Storage almost full!",
    ),
    "mergeData": MessageLookupByLibrary.simpleMessage("Merge Data"),
    "nameAsc": MessageLookupByLibrary.simpleMessage("Name Ascending"),
    "nameDesc": MessageLookupByLibrary.simpleMessage("Name Descending"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "noDuplicatesFound": MessageLookupByLibrary.simpleMessage(
      "No duplicate photos found",
    ),
    "notEarned": MessageLookupByLibrary.simpleMessage("Requirements not met"),
    "notLoggedIn": MessageLookupByLibrary.simpleMessage(
      "Not logged in (Guest)",
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
    "openGalleryManager": MessageLookupByLibrary.simpleMessage(
      "Open Gallery Manager",
    ),
    "openGalleryManagerDescription": MessageLookupByLibrary.simpleMessage(
      "If you want to clean manually by media type, go here. Tap the highlighted button to open it.",
    ),
    "or": MessageLookupByLibrary.simpleMessage("Or"),
    "perfect": MessageLookupByLibrary.simpleMessage("Perfect!"),
    "photoId": m23,
    "progress": MessageLookupByLibrary.simpleMessage("Progress"),
    "quickScan": MessageLookupByLibrary.simpleMessage("Quick Scan"),
    "scanResults": MessageLookupByLibrary.simpleMessage("Scan results"),
    "scanningDevice": MessageLookupByLibrary.simpleMessage(
      "Scanning device...",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "sizeAsc": MessageLookupByLibrary.simpleMessage("Size Ascending"),
    "sizeDesc": MessageLookupByLibrary.simpleMessage("Size Descending"),
    "skip": MessageLookupByLibrary.simpleMessage("Skip"),
    "sort": MessageLookupByLibrary.simpleMessage("Sort"),
    "startFresh": MessageLookupByLibrary.simpleMessage("Start Fresh"),
    "startQuickScan": MessageLookupByLibrary.simpleMessage(
      "Start a quick scan",
    ),
    "startQuickScanDescription": MessageLookupByLibrary.simpleMessage(
      "Use this button to scan your library and detect duplicates in one flow.",
    ),
    "stats": MessageLookupByLibrary.simpleMessage("Stats"),
    "storageAlmostFull": m24,
    "streakDays": m25,
    "streaks": MessageLookupByLibrary.simpleMessage("Streaks"),
    "swipeLeftToDeleteKeepRight": MessageLookupByLibrary.simpleMessage(
      "Swipe left to delete, keep right",
    ),
    "syncDataMessage": MessageLookupByLibrary.simpleMessage(
      "We found some local cleaning data from your guest session. Would you like to merge it into your new account?",
    ),
    "syncDataTitle": MessageLookupByLibrary.simpleMessage("Link guest data?"),
    "tabDashboard": MessageLookupByLibrary.simpleMessage("Achievements"),
    "tabOtherFeatures": MessageLookupByLibrary.simpleMessage("Other Features"),
    "tabScan": MessageLookupByLibrary.simpleMessage("Scan"),
    "tabSettings": MessageLookupByLibrary.simpleMessage("Settings"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "themeSystem": MessageLookupByLibrary.simpleMessage("System"),
    "toNextLevel": m26,
    "totalPhotos": m27,
    "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "vietnamese": MessageLookupByLibrary.simpleMessage("Vietnamese"),
  };
}

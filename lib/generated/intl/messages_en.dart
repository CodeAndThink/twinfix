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

  static String m10(score) => "Blur Score: ${score}";

  static String m11(size) => "Successfully cleaned ${size}";

  static String m12(count) =>
      "Are you sure you want to delete ${count} photos? They will be moved to the system trash. You may need to empty the trash to free up storage.";

  static String m13(badgeName) => "You just earned the \"${badgeName}\" badge!";

  static String m14(count) => "You just earned ${count} new badges!";

  static String m15(count) =>
      "Are you sure you want to delete ${count} duplicate photos? They will be moved to the system trash.";

  static String m16(count) => "Delete (${count})";

  static String m17(count) => "Delete ${count} photos";

  static String m18(count) =>
      "Are you sure you want to delete ${count} photos? They will be moved to the system trash. You may need to empty the trash to free up storage.";

  static String m19(count) => "Deleted ${count} photos successfully";

  static String m20(count) => "Detected ${count} duplicate groups";

  static String m21(count) => "Detected ${count} duplicate photos";

  static String m22(message) => "Error: ${message}";

  static String m23(index, count) => "Group ${index} (${count} photos)";

  static String m24(level) => "Level ${level}";

  static String m25(email) => "Logged in as ${email}";

  static String m26(id) => "ID: ${id}";

  static String m27(percent) =>
      "Storage almost full (${percent}%), clean up now!";

  static String m28(days) => "${days} Days Streak";

  static String m29(percent) => "To next level (${percent})";

  static String m30(count) => "${count} photos";

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
    "awesome": MessageLookupByLibrary.simpleMessage("Awesome!"),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "backgroundStyle": MessageLookupByLibrary.simpleMessage("Background Style"),
    "badgeAiCleanerDesc": MessageLookupByLibrary.simpleMessage(
      "Use the automatic cleanup feature.",
    ),
    "badgeAiCleanerName": MessageLookupByLibrary.simpleMessage("AI Assistant"),
    "badgeBlurry10Desc": MessageLookupByLibrary.simpleMessage(
      "Delete 10 blurry photos.",
    ),
    "badgeBlurry10Name": MessageLookupByLibrary.simpleMessage("Blur Hunter"),
    "badgeBlurry200Desc": MessageLookupByLibrary.simpleMessage(
      "Delete 200 blurry photos.",
    ),
    "badgeBlurry200Name": MessageLookupByLibrary.simpleMessage(
      "Blur Destroyer",
    ),
    "badgeBlurryKillerDesc": MessageLookupByLibrary.simpleMessage(
      "Delete 50 blurry photos.",
    ),
    "badgeBlurryKillerName": MessageLookupByLibrary.simpleMessage(
      "Blur Killer",
    ),
    "badgeCleaner1000Desc": MessageLookupByLibrary.simpleMessage(
      "Delete a total of 1000 photos.",
    ),
    "badgeCleaner1000Name": MessageLookupByLibrary.simpleMessage(
      "Photo Shredder",
    ),
    "badgeCleaner100Desc": MessageLookupByLibrary.simpleMessage(
      "Delete a total of 100 photos.",
    ),
    "badgeCleaner100Name": MessageLookupByLibrary.simpleMessage(
      "Expert Cleaner",
    ),
    "badgeCleaner10Desc": MessageLookupByLibrary.simpleMessage(
      "Delete a total of 10 photos.",
    ),
    "badgeCleaner10Name": MessageLookupByLibrary.simpleMessage(
      "Apprentice Cleaner",
    ),
    "badgeDuplicate100Desc": MessageLookupByLibrary.simpleMessage(
      "Delete 100 duplicate photos.",
    ),
    "badgeDuplicate100Name": MessageLookupByLibrary.simpleMessage(
      "Duplicate Master",
    ),
    "badgeDuplicate20Desc": MessageLookupByLibrary.simpleMessage(
      "Delete 20 duplicate photos.",
    ),
    "badgeDuplicate20Name": MessageLookupByLibrary.simpleMessage(
      "Duplicate Hunter",
    ),
    "badgeFirstCleanDesc": MessageLookupByLibrary.simpleMessage(
      "Delete your very first photos.",
    ),
    "badgeFirstCleanName": MessageLookupByLibrary.simpleMessage("First Clean"),
    "badgeFreed100mbDesc": MessageLookupByLibrary.simpleMessage(
      "Free up a total of 100MB of data.",
    ),
    "badgeFreed100mbName": MessageLookupByLibrary.simpleMessage(
      "Light Cleanup",
    ),
    "badgeFreed10gbDesc": MessageLookupByLibrary.simpleMessage(
      "Free up a total of 10GB of data.",
    ),
    "badgeFreed10gbName": MessageLookupByLibrary.simpleMessage(
      "Disk Destroyer",
    ),
    "badgeFreed5gbDesc": MessageLookupByLibrary.simpleMessage(
      "Free up a total of 5GB of data.",
    ),
    "badgeFreed5gbName": MessageLookupByLibrary.simpleMessage("Storage Hunter"),
    "badgeGigaKingDesc": MessageLookupByLibrary.simpleMessage(
      "Free up more than 1GB of data.",
    ),
    "badgeGigaKingName": MessageLookupByLibrary.simpleMessage("Storage King"),
    "badgeNewbieDesc": MessageLookupByLibrary.simpleMessage(
      "Delete your first photo and start the journey to free your storage.",
    ),
    "badgeNewbieName": MessageLookupByLibrary.simpleMessage("Newbie Cleaner"),
    "badgePerfectionistDesc": MessageLookupByLibrary.simpleMessage(
      "Delete over 80% of blurry photos on your device.",
    ),
    "badgePerfectionistName": MessageLookupByLibrary.simpleMessage(
      "Perfectionist",
    ),
    "badgeSpeedCleanDesc": MessageLookupByLibrary.simpleMessage(
      "Delete 50 photos in a single session.",
    ),
    "badgeSpeedCleanName": MessageLookupByLibrary.simpleMessage(
      "Speed Cleaner",
    ),
    "badgeStreak3Desc": MessageLookupByLibrary.simpleMessage(
      "Clean up for 3 consecutive days.",
    ),
    "badgeStreak3Name": MessageLookupByLibrary.simpleMessage("Dedicated"),
    "badgeStreak7Desc": MessageLookupByLibrary.simpleMessage(
      "Clean up for 7 consecutive days.",
    ),
    "badgeStreak7Name": MessageLookupByLibrary.simpleMessage("Never Give Up"),
    "badges": MessageLookupByLibrary.simpleMessage("Badges"),
    "bgNature1": MessageLookupByLibrary.simpleMessage("Dragon Boat"),
    "bgNature2": MessageLookupByLibrary.simpleMessage("Forest Lake"),
    "bgNature3": MessageLookupByLibrary.simpleMessage("Mountain"),
    "bgNature4": MessageLookupByLibrary.simpleMessage("Sunset"),
    "bgNone": MessageLookupByLibrary.simpleMessage("Clean"),
    "bgPremium": MessageLookupByLibrary.simpleMessage("Premium Abstract"),
    "blurScore": m10,
    "blurryPhotos": MessageLookupByLibrary.simpleMessage("Blurry Photos"),
    "blurryPhotosDescription": MessageLookupByLibrary.simpleMessage(
      "Detect and clean out photos that are blurry or have motion blur.",
    ),
    "calculatingProgress": MessageLookupByLibrary.simpleMessage(
      "Calculating...",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cleanedData": MessageLookupByLibrary.simpleMessage("Cleaned Data"),
    "cleanedSpaceSuccess": m11,
    "clearSelection": MessageLookupByLibrary.simpleMessage("Clear selection"),
    "confirmDelete": MessageLookupByLibrary.simpleMessage("Confirm delete"),
    "confirmDeleteMessage": m12,
    "confirmnoMorePhotosToDelete": MessageLookupByLibrary.simpleMessage(
      "No more photos to delete",
    ),
    "congratsBadgeMessage": m13,
    "congratsBadgeTitle": MessageLookupByLibrary.simpleMessage("New Badge!"),
    "congratsMultipleBadgesMessage": m14,
    "dateAsc": MessageLookupByLibrary.simpleMessage("Date Ascending"),
    "dateDesc": MessageLookupByLibrary.simpleMessage("Date Descending"),
    "deepScan": MessageLookupByLibrary.simpleMessage("Deep Scan"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteDuplicates": MessageLookupByLibrary.simpleMessage(
      "Delete duplicate photos",
    ),
    "deleteDuplicatesMessage": m15,
    "deleteSelected": m16,
    "deleteSelectedPhotos": m17,
    "deleteSelectedPhotosMessage": m18,
    "deleteSuccess": m19,
    "delete_confirm_message": MessageLookupByLibrary.simpleMessage(
      "Please double-check one last time!\nThis action cannot be undone.",
    ),
    "detectedDuplicateGroups": m20,
    "detectedDuplicates": m21,
    "deviceIsClean": MessageLookupByLibrary.simpleMessage(
      "Your device is very clean.",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Got it"),
    "earned": MessageLookupByLibrary.simpleMessage("Unlocked"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "error": m22,
    "galleryManager": MessageLookupByLibrary.simpleMessage("Gallery Manager"),
    "general": MessageLookupByLibrary.simpleMessage("General"),
    "groupIndex": m23,
    "howToEarn": MessageLookupByLibrary.simpleMessage("How to earn?"),
    "howToEarnDescription": MessageLookupByLibrary.simpleMessage(
      "You need to perform more system cleaning steps or invite friends to get this prestigious badge.",
    ),
    "images": MessageLookupByLibrary.simpleMessage("Images"),
    "imagesDescription": MessageLookupByLibrary.simpleMessage(
      "Images are photos that are not animated. Clean them up to free up storage.",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "level": m24,
    "livePhotos": MessageLookupByLibrary.simpleMessage("Live Photos"),
    "livePhotosDescription": MessageLookupByLibrary.simpleMessage(
      "Live Photos are animated photos that can play short videos. Clean them up to free up storage.",
    ),
    "loggedInAs": m25,
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
    "motionBlurDetected": MessageLookupByLibrary.simpleMessage(
      "Potential motion blur detected",
    ),
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
    "photoId": m26,
    "progress": MessageLookupByLibrary.simpleMessage("Progress"),
    "quickScan": MessageLookupByLibrary.simpleMessage("Quick Scan"),
    "scanResults": MessageLookupByLibrary.simpleMessage("Scan results"),
    "scanningDevice": MessageLookupByLibrary.simpleMessage(
      "Scanning device...",
    ),
    "screenshots": MessageLookupByLibrary.simpleMessage("Screenshots"),
    "screenshotsDescription": MessageLookupByLibrary.simpleMessage(
      "Screenshots are photos that are not animated. Clean them up to free up storage.",
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
    "storageAlmostFull": m27,
    "streakDays": m28,
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
    "toNextLevel": m29,
    "totalPhotos": m30,
    "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "videos": MessageLookupByLibrary.simpleMessage("Videos"),
    "videosDescription": MessageLookupByLibrary.simpleMessage(
      "Videos are animated photos that can play short videos. Clean them up to free up storage.",
    ),
    "vietnamese": MessageLookupByLibrary.simpleMessage("Vietnamese"),
  };
}

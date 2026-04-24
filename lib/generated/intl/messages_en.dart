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

  static String m0(num, unit) => "Successfully cleaned ${num} ${unit}";

  static String m1(badgeName) => "You just earned the \"${badgeName}\" badge!";

  static String m2(count) => "You just earned ${count} new badges!";

  static String m3(count) => "Delete (${count})";

  static String m4(count) => "Delete ${count} photos";

  static String m5(count) =>
      "Are you sure you want to delete ${count} photos? They will be moved to the system trash. You may need to empty the trash to free up storage.";

  static String m6(count) => "Deleted ${count} items";

  static String m7(count) => "Detected ${count} duplicate groups";

  static String m8(message) => "Error: ${message}";

  static String m9(index, count) => "Group ${index} (${count} photos)";

  static String m10(level) => "Level ${level}";

  static String m11(percent) =>
      "Storage almost full (${percent}%), clean up now!";

  static String m12(days) => "${days} Days Streak";

  static String m13(count) => "${count} photos";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "accountSyncActive": MessageLookupByLibrary.simpleMessage(
          "Account sync active",
        ),
        "activityDetailTitle": MessageLookupByLibrary.simpleMessage(
          "Cleaning Activity",
        ),
        "addWaterMark": MessageLookupByLibrary.simpleMessage("Add Watermark"),
        "addWaterMarkDescription": MessageLookupByLibrary.simpleMessage(
          "Add watermark to photos.",
        ),
        "appDescription": MessageLookupByLibrary.simpleMessage(
          "Photo Duplicate Cleaner",
        ),
        "appName": MessageLookupByLibrary.simpleMessage("Twinfix"),
        "appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
        "awesome": MessageLookupByLibrary.simpleMessage("Awesome!"),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "backgroundStyle":
            MessageLookupByLibrary.simpleMessage("Background Style"),
        "badgeAiCleanerDesc": MessageLookupByLibrary.simpleMessage(
          "Use the automatic cleanup feature.",
        ),
        "badgeAiCleanerName":
            MessageLookupByLibrary.simpleMessage("AI Assistant"),
        "badgeBlurry10Desc": MessageLookupByLibrary.simpleMessage(
          "Delete 10 blurry photos.",
        ),
        "badgeBlurry10Name":
            MessageLookupByLibrary.simpleMessage("Blur Hunter"),
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
        "badgeFirstCleanName":
            MessageLookupByLibrary.simpleMessage("First Clean"),
        "badgeFreed100mbDesc": MessageLookupByLibrary.simpleMessage(
          "Delete a total of 200 photos.",
        ),
        "badgeFreed100mbName": MessageLookupByLibrary.simpleMessage(
          "Storage Novice",
        ),
        "badgeFreed10gbDesc": MessageLookupByLibrary.simpleMessage(
          "Delete a total of 5000 photos.",
        ),
        "badgeFreed10gbName":
            MessageLookupByLibrary.simpleMessage("Disk Legend"),
        "badgeFreed5gbDesc": MessageLookupByLibrary.simpleMessage(
          "Delete a total of 2000 photos.",
        ),
        "badgeFreed5gbName":
            MessageLookupByLibrary.simpleMessage("Storage Hero"),
        "badgeGigaKingDesc": MessageLookupByLibrary.simpleMessage(
          "Delete a total of 500 photos.",
        ),
        "badgeGigaKingName": MessageLookupByLibrary.simpleMessage(
          "Cleaning Master",
        ),
        "badgeNewbieDesc": MessageLookupByLibrary.simpleMessage(
          "Delete your first photo and start the journey to free your storage.",
        ),
        "badgeNewbieName":
            MessageLookupByLibrary.simpleMessage("Newbie Cleaner"),
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
        "badgeStreak7Name":
            MessageLookupByLibrary.simpleMessage("Never Give Up"),
        "badges": MessageLookupByLibrary.simpleMessage("Badges"),
        "blur": MessageLookupByLibrary.simpleMessage("Blur"),
        "blurFace": MessageLookupByLibrary.simpleMessage("Blur Face"),
        "blurFaceDescription": MessageLookupByLibrary.simpleMessage(
          "Blur face in photos.",
        ),
        "blurryPhotos": MessageLookupByLibrary.simpleMessage("Blurry Photos"),
        "blurryPhotosDescription": MessageLookupByLibrary.simpleMessage(
          "Detect and clean out photos that are blurry or have motion blur.",
        ),
        "calculatingProgress": MessageLookupByLibrary.simpleMessage(
          "Calculating...",
        ),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cleanedData": MessageLookupByLibrary.simpleMessage("Cleaned Data"),
        "cleanedSpaceSuccess": m0,
        "clearSelection":
            MessageLookupByLibrary.simpleMessage("Clear selection"),
        "confirmDelete": MessageLookupByLibrary.simpleMessage("Confirm delete"),
        "confirmnoMorePhotosToDelete": MessageLookupByLibrary.simpleMessage(
          "No more photos to delete",
        ),
        "congratsBadgeMessage": m1,
        "congratsBadgeTitle":
            MessageLookupByLibrary.simpleMessage("New Badge!"),
        "congratsMultipleBadgesMessage": m2,
        "contributionGraph": MessageLookupByLibrary.simpleMessage(
          "CONTRIBUTION GRAPH",
        ),
        "convertImageFailed": MessageLookupByLibrary.simpleMessage(
          "Failed to convert image",
        ),
        "couldNotDecodeImage": MessageLookupByLibrary.simpleMessage(
          "Could not decode image",
        ),
        "createNewImage":
            MessageLookupByLibrary.simpleMessage("Create New Image"),
        "crop": MessageLookupByLibrary.simpleMessage("Crop"),
        "dateAsc": MessageLookupByLibrary.simpleMessage("Date Ascending"),
        "dateDesc": MessageLookupByLibrary.simpleMessage("Date Descending"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteSelected": m3,
        "deleteSelectedPhotos": m4,
        "deleteSelectedPhotosMessage": m5,
        "delete_confirm_message": MessageLookupByLibrary.simpleMessage(
          "Please double-check one last time!\nThis action cannot be undone.",
        ),
        "deletedItemsCount": m6,
        "density": MessageLookupByLibrary.simpleMessage("Density"),
        "detectedDuplicateGroups": m7,
        "deviceIsClean": MessageLookupByLibrary.simpleMessage(
          "Your device is very clean.",
        ),
        "document": MessageLookupByLibrary.simpleMessage("Document Detection"),
        "documentDescription": MessageLookupByLibrary.simpleMessage(
          "Identify and manage images containing text.",
        ),
        "done": MessageLookupByLibrary.simpleMessage("Got it"),
        "earned": MessageLookupByLibrary.simpleMessage("Unlocked"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "editAnotherPhoto": MessageLookupByLibrary.simpleMessage(
          "Edit another photo",
        ),
        "editDescription": MessageLookupByLibrary.simpleMessage("Edit image"),
        "effectBlur": MessageLookupByLibrary.simpleMessage("Blur"),
        "effectEmoji": MessageLookupByLibrary.simpleMessage("Emoji"),
        "effectPixelate": MessageLookupByLibrary.simpleMessage("Pixelate"),
        "effectSolid": MessageLookupByLibrary.simpleMessage("Solid Color"),
        "emoji": MessageLookupByLibrary.simpleMessage("Emoji"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "enterWatermarkText": MessageLookupByLibrary.simpleMessage(
          "Enter watermark text",
        ),
        "error": m8,
        "error_unable_to_play_media": MessageLookupByLibrary.simpleMessage(
          "Unable to play media",
        ),
        "error_unsupported_media_type": MessageLookupByLibrary.simpleMessage(
          "Unsupported media type",
        ),
        "eyeBar": MessageLookupByLibrary.simpleMessage("Eye Bar"),
        "file": MessageLookupByLibrary.simpleMessage("file"),
        "files": MessageLookupByLibrary.simpleMessage("files"),
        "filter": MessageLookupByLibrary.simpleMessage("Filter"),
        "finish": MessageLookupByLibrary.simpleMessage("Finish"),
        "galleryManager":
            MessageLookupByLibrary.simpleMessage("Gallery Manager"),
        "general": MessageLookupByLibrary.simpleMessage("General"),
        "glasses": MessageLookupByLibrary.simpleMessage("Glasses"),
        "gpsRemovedSuccess": MessageLookupByLibrary.simpleMessage(
          "GPS location data removed and saved as a new copy.",
        ),
        "groupIndex": m9,
        "history": MessageLookupByLibrary.simpleMessage("HISTORY"),
        "howToEarn": MessageLookupByLibrary.simpleMessage("How to earn?"),
        "howToEarnDescription": MessageLookupByLibrary.simpleMessage(
          "You need to perform more system cleaning steps or invite friends to get this prestigious badge.",
        ),
        "imageSaved": MessageLookupByLibrary.simpleMessage(
          "Image saved successfully!",
        ),
        "intensity": MessageLookupByLibrary.simpleMessage("Intensity"),
        "itemsDeleted": MessageLookupByLibrary.simpleMessage("Items Deleted"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "level": m10,
        "livePhotos": MessageLookupByLibrary.simpleMessage("Live Photos"),
        "livePhotosDescription": MessageLookupByLibrary.simpleMessage(
          "Live Photos are animated photos that can play short videos. Clean them up to free up storage.",
        ),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginToSync": MessageLookupByLibrary.simpleMessage(
          "Log in to sync your progress across devices",
        ),
        "logout": MessageLookupByLibrary.simpleMessage("Log out"),
        "longPressToSelectAll": MessageLookupByLibrary.simpleMessage(
          "Long press to select all",
        ),
        "mask": MessageLookupByLibrary.simpleMessage("Face Mask"),
        "mediaInfo": MessageLookupByLibrary.simpleMessage("Media Info"),
        "media_audio": MessageLookupByLibrary.simpleMessage("Audio"),
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
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "noActivity": MessageLookupByLibrary.simpleMessage(
          "No cleaning activity yet",
        ),
        "noDocumentsFound": MessageLookupByLibrary.simpleMessage(
          "No images with text found.",
        ),
        "noDuplicatesFound": MessageLookupByLibrary.simpleMessage(
          "No duplicate photos found",
        ),
        "noFacesDetected": MessageLookupByLibrary.simpleMessage(
          "No faces detected in this photo.",
        ),
        "noPhotosWithGPSFound": MessageLookupByLibrary.simpleMessage(
          "No images with location data found.",
        ),
        "notEarned":
            MessageLookupByLibrary.simpleMessage("Requirements not met"),
        "notLoggedIn": MessageLookupByLibrary.simpleMessage(
          "Not logged in (Guest)",
        ),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "onboardingDemoSwipeLeft": MessageLookupByLibrary.simpleMessage(
          "Swipe Left to Delete",
        ),
        "onboardingDemoSwipeRight": MessageLookupByLibrary.simpleMessage(
          "Swipe Right to Keep",
        ),
        "onboardingStartScan": MessageLookupByLibrary.simpleMessage(
          "Start Scanning",
        ),
        "onboardingWelcomeTitle": MessageLookupByLibrary.simpleMessage(
          "Welcome to Twinfix",
        ),
        "opacity": MessageLookupByLibrary.simpleMessage("Opacity"),
        "openGalleryManager": MessageLookupByLibrary.simpleMessage(
          "Open Gallery Manager",
        ),
        "openGalleryManagerDescription": MessageLookupByLibrary.simpleMessage(
          "If you want to clean manually by media type, go here. Tap the highlighted button to open it.",
        ),
        "or": MessageLookupByLibrary.simpleMessage("Or"),
        "paint": MessageLookupByLibrary.simpleMessage("Paint"),
        "perfect": MessageLookupByLibrary.simpleMessage("Perfect!"),
        "pixelate": MessageLookupByLibrary.simpleMessage("Pixelate"),
        "pleaseEnterWatermarkText": MessageLookupByLibrary.simpleMessage(
          "Please enter watermark text",
        ),
        "progress": MessageLookupByLibrary.simpleMessage("Progress"),
        "removeGPS": MessageLookupByLibrary.simpleMessage("Remove GPS"),
        "removeGPSDescription": MessageLookupByLibrary.simpleMessage(
          "Remove GPS information from photos.",
        ),
        "replaceOriginal":
            MessageLookupByLibrary.simpleMessage("Replace Original"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saving": MessageLookupByLibrary.simpleMessage("Saving..."),
        "scanResults": MessageLookupByLibrary.simpleMessage("Scan results"),
        "scanningDevice": MessageLookupByLibrary.simpleMessage(
          "Scanning device...",
        ),
        "screenshots": MessageLookupByLibrary.simpleMessage("Screenshots"),
        "screenshotsDescription": MessageLookupByLibrary.simpleMessage(
          "Screenshots are photos that are not animated. Clean them up to free up storage.",
        ),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "selectEmoji": MessageLookupByLibrary.simpleMessage("Select Emoji"),
        "selectTemplate":
            MessageLookupByLibrary.simpleMessage("Select Template"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "size": MessageLookupByLibrary.simpleMessage("Size"),
        "sizeAsc": MessageLookupByLibrary.simpleMessage("Size Ascending"),
        "sizeDesc": MessageLookupByLibrary.simpleMessage("Size Descending"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "solid": MessageLookupByLibrary.simpleMessage("Solid"),
        "sort": MessageLookupByLibrary.simpleMessage("Sort"),
        "startFresh": MessageLookupByLibrary.simpleMessage("Start Fresh"),
        "startQuickScan": MessageLookupByLibrary.simpleMessage(
          "Start a quick scan",
        ),
        "startQuickScanDescription": MessageLookupByLibrary.simpleMessage(
          "Use this button to scan your library and detect duplicates in one flow.",
        ),
        "stats": MessageLookupByLibrary.simpleMessage("Stats"),
        "storageAlmostFull": m11,
        "streakDays": m12,
        "streaks": MessageLookupByLibrary.simpleMessage("Streaks"),
        "success": MessageLookupByLibrary.simpleMessage("Success"),
        "syncDataMessage": MessageLookupByLibrary.simpleMessage(
          "We found some local cleaning data from your guest session. Would you like to merge it into your new account?",
        ),
        "syncDataTitle":
            MessageLookupByLibrary.simpleMessage("Link guest data?"),
        "tabDashboard": MessageLookupByLibrary.simpleMessage("Achievements"),
        "tabOtherFeatures":
            MessageLookupByLibrary.simpleMessage("Other Features"),
        "tabScan": MessageLookupByLibrary.simpleMessage("Scan"),
        "tabSettings": MessageLookupByLibrary.simpleMessage("Settings"),
        "tapToChangeStyle": MessageLookupByLibrary.simpleMessage(
          "Tap to change style",
        ),
        "template_copyright": MessageLookupByLibrary.simpleMessage("Copyright"),
        "template_glass": MessageLookupByLibrary.simpleMessage("Glass"),
        "template_minimal": MessageLookupByLibrary.simpleMessage("Minimal"),
        "template_outline": MessageLookupByLibrary.simpleMessage("Outline"),
        "template_standard": MessageLookupByLibrary.simpleMessage("Standard"),
        "text": MessageLookupByLibrary.simpleMessage("Text"),
        "theme": MessageLookupByLibrary.simpleMessage("Theme"),
        "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
        "themeLight": MessageLookupByLibrary.simpleMessage("Light"),
        "themeSystem": MessageLookupByLibrary.simpleMessage("System"),
        "totalPhotos": m13,
        "tune": MessageLookupByLibrary.simpleMessage("Tune"),
        "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
        "vietnamese": MessageLookupByLibrary.simpleMessage("Vietnamese"),
        "watermarkText": MessageLookupByLibrary.simpleMessage("Watermark Text"),
      };
}

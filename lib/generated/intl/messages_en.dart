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

  static String m0(version) => "Version ${version}";

  static String m1(num, unit) => "Successfully cleaned ${num} ${unit}";

  static String m2(badgeName) => "You just earned the \"${badgeName}\" badge!";

  static String m3(count) => "You just earned ${count} new badges!";

  static String m4(count) => "Delete (${count})";

  static String m5(count) => "Delete ${count} photos";

  static String m6(count) =>
      "Are you sure you want to delete ${count} photos? They will be moved to the system trash. You may need to empty the trash to free up storage.";

  static String m7(count) => "Deleted ${count} items";

  static String m8(count) => "Detected ${count} duplicate groups";

  static String m9(message) => "Error: ${message}";

  static String m10(index, count) => "Group ${index} (${count} photos)";

  static String m11(level) => "Level ${level}";

  static String m12(percent) =>
      "Storage almost full (${percent}%), clean up now!";

  static String m13(days) => "${days} Days Streak";

  static String m14(count) => "${count} photos";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutDescription": MessageLookupByLibrary.simpleMessage(
      "Twinfix is a powerful tool designed to help you organize and clean up your photo gallery with ease using AI.",
    ),
    "aboutUs": MessageLookupByLibrary.simpleMessage("About Us"),
    "account": MessageLookupByLibrary.simpleMessage("Account"),
    "accountSyncActive": MessageLookupByLibrary.simpleMessage(
      "Account sync active",
    ),
    "activity": MessageLookupByLibrary.simpleMessage("Activity"),
    "activityDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Cleaning Activity",
    ),
    "addWaterMark": MessageLookupByLibrary.simpleMessage("Add Watermark"),
    "addWaterMarkDescription": MessageLookupByLibrary.simpleMessage(
      "Add watermark to photos.",
    ),
    "allBadges": MessageLookupByLibrary.simpleMessage("All Badges"),
    "alreadyHaveAccountLogin": MessageLookupByLibrary.simpleMessage(
      "Already have an account? Login",
    ),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "Photo Duplicate Cleaner",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("Twinfix"),
    "appVersion": m0,
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
      "Delete a total of 200 photos.",
    ),
    "badgeFreed100mbName": MessageLookupByLibrary.simpleMessage(
      "Storage Novice",
    ),
    "badgeFreed10gbDesc": MessageLookupByLibrary.simpleMessage(
      "Delete a total of 5000 photos.",
    ),
    "badgeFreed10gbName": MessageLookupByLibrary.simpleMessage("Disk Legend"),
    "badgeFreed5gbDesc": MessageLookupByLibrary.simpleMessage(
      "Delete a total of 2000 photos.",
    ),
    "badgeFreed5gbName": MessageLookupByLibrary.simpleMessage("Storage Hero"),
    "badgeGigaKingDesc": MessageLookupByLibrary.simpleMessage(
      "Delete a total of 500 photos.",
    ),
    "badgeGigaKingName": MessageLookupByLibrary.simpleMessage(
      "Cleaning Master",
    ),
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
    "blur": MessageLookupByLibrary.simpleMessage("Blur"),
    "blurFace": MessageLookupByLibrary.simpleMessage("Blur Face"),
    "blurFaceDescription": MessageLookupByLibrary.simpleMessage(
      "Blur face in photos.",
    ),
    "blurryDeleted": MessageLookupByLibrary.simpleMessage("Blurry Deleted"),
    "blurryPhotos": MessageLookupByLibrary.simpleMessage("Blurry Photos"),
    "blurryPhotosDescription": MessageLookupByLibrary.simpleMessage(
      "Detect and clean out photos that are blurry or have motion blur.",
    ),
    "calculatingProgress": MessageLookupByLibrary.simpleMessage(
      "Calculating...",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cleaned": MessageLookupByLibrary.simpleMessage("Cleaned"),
    "cleanedData": MessageLookupByLibrary.simpleMessage("Cleaned Data"),
    "cleanedSpaceSuccess": m1,
    "clearSelection": MessageLookupByLibrary.simpleMessage("Clear selection"),
    "confirmDelete": MessageLookupByLibrary.simpleMessage("Confirm delete"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "confirmPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Confirm password is required",
    ),
    "confirmnoMorePhotosToDelete": MessageLookupByLibrary.simpleMessage(
      "No more photos to delete",
    ),
    "congratsBadgeMessage": m2,
    "congratsBadgeTitle": MessageLookupByLibrary.simpleMessage("New Badge!"),
    "congratsMultipleBadgesMessage": m3,
    "contactUs": MessageLookupByLibrary.simpleMessage("Contact Us"),
    "continueWithFreeVersion": MessageLookupByLibrary.simpleMessage(
      "Continue with Free Version",
    ),
    "contributionGraph": MessageLookupByLibrary.simpleMessage(
      "CONTRIBUTION GRAPH",
    ),
    "convertImageFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to convert image",
    ),
    "couldNotDecodeImage": MessageLookupByLibrary.simpleMessage(
      "Could not decode image",
    ),
    "createAccount": MessageLookupByLibrary.simpleMessage("Create an Account"),
    "createNewImage": MessageLookupByLibrary.simpleMessage("Create New Image"),
    "crop": MessageLookupByLibrary.simpleMessage("Crop"),
    "dateAsc": MessageLookupByLibrary.simpleMessage("Date Ascending"),
    "dateDesc": MessageLookupByLibrary.simpleMessage("Date Descending"),
    "days": MessageLookupByLibrary.simpleMessage("Days"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteSelected": m4,
    "deleteSelectedPhotos": m5,
    "deleteSelectedPhotosMessage": m6,
    "delete_confirm_message": MessageLookupByLibrary.simpleMessage(
      "Please double-check one last time!\nThis action cannot be undone.",
    ),
    "deletedItemsCount": m7,
    "density": MessageLookupByLibrary.simpleMessage("Density"),
    "detectedDuplicateGroups": m8,
    "deviceIsClean": MessageLookupByLibrary.simpleMessage(
      "Your device is very clean.",
    ),
    "document": MessageLookupByLibrary.simpleMessage("Document Detection"),
    "documentDescription": MessageLookupByLibrary.simpleMessage(
      "Identify and manage images containing text.",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Got it"),
    "duplicates": MessageLookupByLibrary.simpleMessage("Duplicates"),
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
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emailInvalid": MessageLookupByLibrary.simpleMessage(
      "Invalid email format",
    ),
    "emailRequired": MessageLookupByLibrary.simpleMessage("Email is required"),
    "emoji": MessageLookupByLibrary.simpleMessage("Emoji"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "enterWatermarkText": MessageLookupByLibrary.simpleMessage(
      "Enter watermark text",
    ),
    "error": m9,
    "error_unable_to_play_media": MessageLookupByLibrary.simpleMessage(
      "Unable to play media",
    ),
    "error_unsupported_media_type": MessageLookupByLibrary.simpleMessage(
      "Unsupported media type",
    ),
    "eyeBar": MessageLookupByLibrary.simpleMessage("Eye Bar"),
    "failedToSendResetLink": MessageLookupByLibrary.simpleMessage(
      "Failed to send reset link",
    ),
    "featureClean": MessageLookupByLibrary.simpleMessage("Efficient Cleaning"),
    "featureMascot": MessageLookupByLibrary.simpleMessage(
      "Friendly Mascot Support",
    ),
    "featureScan": MessageLookupByLibrary.simpleMessage("Fast Scanning"),
    "featuresTitle": MessageLookupByLibrary.simpleMessage("Key Features"),
    "file": MessageLookupByLibrary.simpleMessage("file"),
    "files": MessageLookupByLibrary.simpleMessage("files"),
    "filter": MessageLookupByLibrary.simpleMessage("Filter"),
    "finish": MessageLookupByLibrary.simpleMessage("Finish"),
    "forgotPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Enter your email address and we will send you a link to reset your password.",
    ),
    "forgotPasswordQuestion": MessageLookupByLibrary.simpleMessage(
      "Forgot Password?",
    ),
    "forgotPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Forgot Password",
    ),
    "freePlan": MessageLookupByLibrary.simpleMessage("Free Plan"),
    "fri": MessageLookupByLibrary.simpleMessage("Fri"),
    "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
    "galleryManager": MessageLookupByLibrary.simpleMessage("Gallery Manager"),
    "general": MessageLookupByLibrary.simpleMessage("General"),
    "glasses": MessageLookupByLibrary.simpleMessage("Glasses"),
    "gpsRemovedSuccess": MessageLookupByLibrary.simpleMessage(
      "GPS location data removed and saved as a new copy.",
    ),
    "grantPermission": MessageLookupByLibrary.simpleMessage("Grant Permission"),
    "groupIndex": m10,
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
    "less": MessageLookupByLibrary.simpleMessage("Less"),
    "level": m11,
    "livePhotos": MessageLookupByLibrary.simpleMessage("Live Photos"),
    "livePhotosDescription": MessageLookupByLibrary.simpleMessage(
      "Live Photos are animated photos that can play short videos. Clean them up to free up storage.",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginSuccess": MessageLookupByLibrary.simpleMessage("Login successful"),
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
    "mon": MessageLookupByLibrary.simpleMessage("Mon"),
    "more": MessageLookupByLibrary.simpleMessage("More"),
    "nameLength": MessageLookupByLibrary.simpleMessage(
      "Name must be at least 2 characters",
    ),
    "nameRequired": MessageLookupByLibrary.simpleMessage("Name is required"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "noAccountRegister": MessageLookupByLibrary.simpleMessage(
      "Do not have an account? Register",
    ),
    "noActivity": MessageLookupByLibrary.simpleMessage(
      "No cleaning activity yet",
    ),
    "noBadgesEarnedYet": MessageLookupByLibrary.simpleMessage(
      "No badges earned yet",
    ),
    "noDocumentsFound": MessageLookupByLibrary.simpleMessage(
      "No images with text found.",
    ),
    "noDuplicatesFound": MessageLookupByLibrary.simpleMessage(
      "No duplicate photos found",
    ),
    "noEmailProvided": MessageLookupByLibrary.simpleMessage(
      "No email provided",
    ),
    "noFacesDetected": MessageLookupByLibrary.simpleMessage(
      "No faces detected in this photo.",
    ),
    "noPhotosWithGPSFound": MessageLookupByLibrary.simpleMessage(
      "No images with location data found.",
    ),
    "notEarned": MessageLookupByLibrary.simpleMessage("Requirements not met"),
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
    "openSettings": MessageLookupByLibrary.simpleMessage("Open Settings"),
    "or": MessageLookupByLibrary.simpleMessage("Or"),
    "packageFreeDescription": MessageLookupByLibrary.simpleMessage(
      "Ad-supported version with limited features",
    ),
    "packageFreePrice": MessageLookupByLibrary.simpleMessage("Free"),
    "packageFreeTitle": MessageLookupByLibrary.simpleMessage("Free"),
    "packageLifetimeDescription": MessageLookupByLibrary.simpleMessage(
      "One-time purchase, keep forever.",
    ),
    "packageLifetimeTitle": MessageLookupByLibrary.simpleMessage("Lifetime"),
    "packageMonthlyDescription": MessageLookupByLibrary.simpleMessage(
      "Monthly subscription. Cancel anytime.",
    ),
    "packageMonthlyTitle": MessageLookupByLibrary.simpleMessage("1 Month"),
    "paint": MessageLookupByLibrary.simpleMessage("Paint"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordLength": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 8 characters, include uppercase, lowercase, number and special character",
    ),
    "passwordRequired": MessageLookupByLibrary.simpleMessage(
      "Password is required",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "paywallSubtitle": MessageLookupByLibrary.simpleMessage(
      "Enjoy all professional features without limits.",
    ),
    "paywallTitle": MessageLookupByLibrary.simpleMessage("Unlock Premium"),
    "paywallWelcomeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Unlock the full potential of your gallery with AI-powered tools and an ad-free experience.",
    ),
    "paywallWelcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Welcome to Premium",
    ),
    "perfect": MessageLookupByLibrary.simpleMessage("Perfect!"),
    "permissionDescription": MessageLookupByLibrary.simpleMessage(
      "Twinfix needs access to your photo library to scan and clean duplicate photos.",
    ),
    "permissionRequired": MessageLookupByLibrary.simpleMessage(
      "Permission Required",
    ),
    "pixelate": MessageLookupByLibrary.simpleMessage("Pixelate"),
    "pleaseEnterWatermarkText": MessageLookupByLibrary.simpleMessage(
      "Please enter watermark text",
    ),
    "popular": MessageLookupByLibrary.simpleMessage("MOST POPULAR"),
    "premiumFeatureAiTools": MessageLookupByLibrary.simpleMessage(
      "Unlock all AI tools",
    ),
    "premiumFeatureHighQuality": MessageLookupByLibrary.simpleMessage(
      "High-quality image editing",
    ),
    "premiumFeatureNoAds": MessageLookupByLibrary.simpleMessage(
      "No advertisements",
    ),
    "premiumPlan": MessageLookupByLibrary.simpleMessage("Premium Plan"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "progress": MessageLookupByLibrary.simpleMessage("Progress"),
    "purchaseErrorStoreConnection": MessageLookupByLibrary.simpleMessage(
      "Could not connect to store.",
    ),
    "purchaseSuccess": MessageLookupByLibrary.simpleMessage(
      "Premium upgrade successful!",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Register"),
    "registerSuccess": MessageLookupByLibrary.simpleMessage(
      "Registration successful",
    ),
    "removeGPS": MessageLookupByLibrary.simpleMessage("Remove GPS"),
    "removeGPSDescription": MessageLookupByLibrary.simpleMessage(
      "Remove GPS information from photos.",
    ),
    "replaceOriginal": MessageLookupByLibrary.simpleMessage("Replace Original"),
    "resetLinkSent": MessageLookupByLibrary.simpleMessage(
      "Reset link sent to your email!",
    ),
    "restorePurchases": MessageLookupByLibrary.simpleMessage(
      "Restore Purchases",
    ),
    "sat": MessageLookupByLibrary.simpleMessage("Sat"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saving": MessageLookupByLibrary.simpleMessage("Saving..."),
    "scanLimit": MessageLookupByLibrary.simpleMessage("Scan Limit"),
    "scanLimitAll": MessageLookupByLibrary.simpleMessage("All"),
    "scanLimitDescription": MessageLookupByLibrary.simpleMessage(
      "The maximum number of photos to scan.",
    ),
    "scanLimitWarning": MessageLookupByLibrary.simpleMessage(
      "Scanning all photos may take a long time and use more battery.",
    ),
    "scanResults": MessageLookupByLibrary.simpleMessage("Scan results"),
    "scanningDevice": MessageLookupByLibrary.simpleMessage(
      "Scanning device...",
    ),
    "scanningDocument": MessageLookupByLibrary.simpleMessage(
      "Scanning document...",
    ),
    "screenshots": MessageLookupByLibrary.simpleMessage("Screenshots"),
    "screenshotsDescription": MessageLookupByLibrary.simpleMessage(
      "Screenshots are photos that are not animated. Clean them up to free up storage.",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "selectEmoji": MessageLookupByLibrary.simpleMessage("Select Emoji"),
    "selectTemplate": MessageLookupByLibrary.simpleMessage("Select Template"),
    "sendResetLink": MessageLookupByLibrary.simpleMessage("Send Reset Link"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "signInWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Sign in with Google",
    ),
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
    "storageAlmostFull": m12,
    "streak": MessageLookupByLibrary.simpleMessage("Streak"),
    "streakDays": m13,
    "streaks": MessageLookupByLibrary.simpleMessage("Streaks"),
    "success": MessageLookupByLibrary.simpleMessage("Success"),
    "sun": MessageLookupByLibrary.simpleMessage("Sun"),
    "syncDataMessage": MessageLookupByLibrary.simpleMessage(
      "We found some local cleaning data from your guest session. Would you like to merge it into your new account?",
    ),
    "syncDataTitle": MessageLookupByLibrary.simpleMessage("Link guest data?"),
    "tabDashboard": MessageLookupByLibrary.simpleMessage("Achievements"),
    "tabOtherFeatures": MessageLookupByLibrary.simpleMessage("Other Features"),
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
    "termsOfService": MessageLookupByLibrary.simpleMessage("Terms of Service"),
    "text": MessageLookupByLibrary.simpleMessage("Text"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "themeSystem": MessageLookupByLibrary.simpleMessage("System"),
    "thu": MessageLookupByLibrary.simpleMessage("Thu"),
    "totalPhotos": m14,
    "tue": MessageLookupByLibrary.simpleMessage("Tue"),
    "tune": MessageLookupByLibrary.simpleMessage("Tune"),
    "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "unknownUser": MessageLookupByLibrary.simpleMessage("Unknown User"),
    "upgradeToPremium": MessageLookupByLibrary.simpleMessage(
      "Upgrade to Premium",
    ),
    "vietnamese": MessageLookupByLibrary.simpleMessage("Vietnamese"),
    "viewAllBadges": MessageLookupByLibrary.simpleMessage("View All Badges"),
    "viewFullHistory": MessageLookupByLibrary.simpleMessage(
      "View full history",
    ),
    "watermarkText": MessageLookupByLibrary.simpleMessage("Watermark Text"),
    "website": MessageLookupByLibrary.simpleMessage("Website"),
    "wed": MessageLookupByLibrary.simpleMessage("Wed"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome Back"),
  };
}

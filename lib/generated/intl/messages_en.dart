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

  static String m1(num, unit, size) =>
      "Successfully cleaned ${num} ${unit} (${size})";

  static String m2(badgeName) => "You just earned the \"${badgeName}\" badge!";

  static String m3(count) => "You just earned ${count} new badges!";

  static String m4(email) =>
      "Could not open email app. Support email: ${email}";

  static String m5(count) => "Delete (${count})";

  static String m6(count) => "Delete ${count} photos";

  static String m7(count) =>
      "Are you sure you want to delete ${count} photos? They will be moved to the system trash. You may need to empty the trash to free up storage.";

  static String m8(count, size) => "Delete (${count}) • ${size}";

  static String m9(count) => "Deleted ${count} items";

  static String m10(count) => "Detected ${count} duplicate groups";

  static String m11(message) => "Error: ${message}";

  static String m12(index, count) => "Group ${index} (${count} photos)";

  static String m13(date) => "Last updated: ${date}";

  static String m14(level) => "Level ${level}";

  static String m15(percent) =>
      "Storage almost full (${percent}%), clean up now!";

  static String m16(days) => "${days} Days Streak";

  static String m17(count) => "${count} photos";

  static String m18(count, mediaType) =>
      "Total: ${count} ${mediaType} (last 7 days)";

  static String m19(count, mediaType) =>
      "Total: ${count} ${mediaType} (last 7 weeks)";

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
    "becomeOneOfUs": MessageLookupByLibrary.simpleMessage("Become one of us"),
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
    "cancelMonthlyMessage": MessageLookupByLibrary.simpleMessage(
      "You\'ve successfully upgraded to Lifetime! Since you previously had a Monthly subscription, please remember to cancel it in the App Store/Google Play to avoid being charged for both.",
    ),
    "cancelMonthlyTitle": MessageLookupByLibrary.simpleMessage(
      "Action Required",
    ),
    "changeFrame": MessageLookupByLibrary.simpleMessage("Change Frame"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change Password"),
    "changePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Password changed successfully",
    ),
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
      "Contribution graph",
    ),
    "convertImageFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to convert image",
    ),
    "couldNotDecodeImage": MessageLookupByLibrary.simpleMessage(
      "Could not decode image",
    ),
    "couldNotOpenEmailApp": m4,
    "createAccount": MessageLookupByLibrary.simpleMessage("Create an Account"),
    "createNewImage": MessageLookupByLibrary.simpleMessage("Create New Image"),
    "crop": MessageLookupByLibrary.simpleMessage("Crop"),
    "currentPlan": MessageLookupByLibrary.simpleMessage("Current Plan"),
    "dataSynchronizedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Data synchronized successfully",
    ),
    "dateAsc": MessageLookupByLibrary.simpleMessage("Date Ascending"),
    "dateDesc": MessageLookupByLibrary.simpleMessage("Date Descending"),
    "days": MessageLookupByLibrary.simpleMessage("Days"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteSelected": m5,
    "deleteSelectedPhotos": m6,
    "deleteSelectedPhotosMessage": m7,
    "deleteSelectedWithCountAndSize": m8,
    "delete_confirm_message": MessageLookupByLibrary.simpleMessage(
      "Please double-check one last time!\nThis action cannot be undone.",
    ),
    "deletedItemsCount": m9,
    "density": MessageLookupByLibrary.simpleMessage("Density"),
    "detectedDuplicateGroups": m10,
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
    "error": m11,
    "errorEmailNotFound": MessageLookupByLibrary.simpleMessage(
      "Error email not found",
    ),
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
    "featureModernUI": MessageLookupByLibrary.simpleMessage(
      "Modern User Interface",
    ),
    "featureScan": MessageLookupByLibrary.simpleMessage("Fast Scanning"),
    "featuresTitle": MessageLookupByLibrary.simpleMessage("Key Features"),
    "feedbackContentHint": MessageLookupByLibrary.simpleMessage(
      "Enter details of the bug or improvement suggestion here...",
    ),
    "feedbackContentLabel": MessageLookupByLibrary.simpleMessage(
      "Detailed Content",
    ),
    "feedbackContentRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter detailed content",
    ),
    "feedbackTitleHint": MessageLookupByLibrary.simpleMessage(
      "Enter feedback title...",
    ),
    "feedbackTitleLabel": MessageLookupByLibrary.simpleMessage("Title"),
    "feedbackTitleRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter title",
    ),
    "feedbackTypeBug": MessageLookupByLibrary.simpleMessage("Bug"),
    "feedbackTypeImprovement": MessageLookupByLibrary.simpleMessage(
      "Improvement",
    ),
    "feedbackTypeLabel": MessageLookupByLibrary.simpleMessage("Feedback Type"),
    "feedbackTypeOther": MessageLookupByLibrary.simpleMessage("Other"),
    "feedbackTypeQuestion": MessageLookupByLibrary.simpleMessage("Question"),
    "file": MessageLookupByLibrary.simpleMessage("file"),
    "files": MessageLookupByLibrary.simpleMessage("files"),
    "filter": MessageLookupByLibrary.simpleMessage("Filter"),
    "finish": MessageLookupByLibrary.simpleMessage("Finish"),
    "footerTitle": MessageLookupByLibrary.simpleMessage("Contact Us"),
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
    "googleLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Google sign in failed. Please try again.",
    ),
    "googleLoginSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Google sign in successfully!",
    ),
    "gpsRemovedSuccess": MessageLookupByLibrary.simpleMessage(
      "GPS location data removed and saved as a new copy.",
    ),
    "grantPermission": MessageLookupByLibrary.simpleMessage("Grant Permission"),
    "groupIndex": m12,
    "history": MessageLookupByLibrary.simpleMessage("History"),
    "historyEarlier": MessageLookupByLibrary.simpleMessage("Earlier"),
    "historyLast7Days": MessageLookupByLibrary.simpleMessage("Last 7 Days"),
    "historyThisMonth": MessageLookupByLibrary.simpleMessage("This Month"),
    "historyToday": MessageLookupByLibrary.simpleMessage("Today"),
    "historyYesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "howToEarn": MessageLookupByLibrary.simpleMessage("How to earn?"),
    "howToEarnDescription": MessageLookupByLibrary.simpleMessage(
      "You need to perform more system cleaning steps or invite friends to get this prestigious badge.",
    ),
    "imageSaved": MessageLookupByLibrary.simpleMessage(
      "Image saved successfully!",
    ),
    "includedInLifetime": MessageLookupByLibrary.simpleMessage(
      "Included in Lifetime",
    ),
    "intensity": MessageLookupByLibrary.simpleMessage("Intensity"),
    "itemsDeleted": MessageLookupByLibrary.simpleMessage("Items Deleted"),
    "keepLocalData": MessageLookupByLibrary.simpleMessage("Keep Local Data"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "lastUpdatedDate": m13,
    "less": MessageLookupByLibrary.simpleMessage("Less"),
    "level": m14,
    "livePhotos": MessageLookupByLibrary.simpleMessage("Live Photos"),
    "livePhotosDescription": MessageLookupByLibrary.simpleMessage(
      "Live Photos are animated photos that can play short videos. Clean them up to free up storage.",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginFailureMessage": MessageLookupByLibrary.simpleMessage(
      "Login failed. Please try again.",
    ),
    "loginSuccess": MessageLookupByLibrary.simpleMessage("Login successful"),
    "loginSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Login successfully!",
    ),
    "loginToSync": MessageLookupByLibrary.simpleMessage(
      "Log in to sync your progress across devices",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Log out"),
    "longPressToSelectAll": MessageLookupByLibrary.simpleMessage(
      "Long press to select all",
    ),
    "manageSubscriptions": MessageLookupByLibrary.simpleMessage(
      "Manage Subscriptions",
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
    "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
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
    "nothingFound": MessageLookupByLibrary.simpleMessage("Nothing found"),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "oldPassword": MessageLookupByLibrary.simpleMessage("Old Password"),
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
    "openingEmailApp": MessageLookupByLibrary.simpleMessage(
      "Opening email app to send feedback...",
    ),
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
    "passwordTooShort": MessageLookupByLibrary.simpleMessage(
      "Password is too short",
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
    "pleaseFillAllFields": MessageLookupByLibrary.simpleMessage(
      "Please fill all fields",
    ),
    "popular": MessageLookupByLibrary.simpleMessage("MOST POPULAR"),
    "premium": MessageLookupByLibrary.simpleMessage("Premium"),
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
    "privacyMatters": MessageLookupByLibrary.simpleMessage(
      "Your Privacy Matters",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "privacySec1Content": MessageLookupByLibrary.simpleMessage(
      "At Twinfix, we are dedicated to protecting your personal data and respect your privacy. This Privacy Policy details how we collect, store, process, and protect your information when you utilize our image cleaning and optimization services.",
    ),
    "privacySec1Title": MessageLookupByLibrary.simpleMessage(
      "1. Commitment to Privacy",
    ),
    "privacySec2Content": MessageLookupByLibrary.simpleMessage(
      "We process image metadata, photo metrics, and files directly on your local device to perform face blurring, watermark removal, duplicate detection, and metadata deletion. Local analysis ensures your original photos are never uploaded to any remote servers without your explicit consent.",
    ),
    "privacySec2Title": MessageLookupByLibrary.simpleMessage(
      "2. Information We Collect",
    ),
    "privacySec3Content": MessageLookupByLibrary.simpleMessage(
      "All optimization tools, duplicate scanning algorithms, and processing layers run natively on your smartphone. We do not store or transmit any image content to external cloud storage. When user profiles sync with Supabase, only metadata (like streak count, cleaning badges, and general stats) is synchronized securely.",
    ),
    "privacySec3Title": MessageLookupByLibrary.simpleMessage(
      "3. Data Storage & Transfer",
    ),
    "privacySec4Content": MessageLookupByLibrary.simpleMessage(
      "We prioritize the safety of your information. We apply robust device-level cryptographic practices and industry-leading transport security protocol (HTTPS/TLS) for account interactions and statistics sync. No third parties can access your processed files.",
    ),
    "privacySec4Title": MessageLookupByLibrary.simpleMessage(
      "4. Information Security",
    ),
    "privacySec5Content": MessageLookupByLibrary.simpleMessage(
      "If you have any questions or feedback regarding this Privacy Policy or data handling practices in Twinfix, please contact us through the official support website or in-app feedback channel.",
    ),
    "privacySec5Title": MessageLookupByLibrary.simpleMessage("5. Contact Us"),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Profile updated successfully!",
    ),
    "progress": MessageLookupByLibrary.simpleMessage("Progress"),
    "purchaseErrorStoreConnection": MessageLookupByLibrary.simpleMessage(
      "Could not connect to store.",
    ),
    "purchaseFailureMessage": MessageLookupByLibrary.simpleMessage(
      "Purchase failed or was cancelled.",
    ),
    "purchaseSuccess": MessageLookupByLibrary.simpleMessage(
      "Premium upgrade successful!",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Register"),
    "registerSuccess": MessageLookupByLibrary.simpleMessage(
      "Registration successful",
    ),
    "registerSuccessMessage": MessageLookupByLibrary.simpleMessage(
      "Please check your email to verify your account before logging in.",
    ),
    "removeGPS": MessageLookupByLibrary.simpleMessage("Remove GPS"),
    "removeGPSDescription": MessageLookupByLibrary.simpleMessage(
      "Remove GPS information from photos.",
    ),
    "replaceOriginal": MessageLookupByLibrary.simpleMessage("Replace Original"),
    "resetLinkSent": MessageLookupByLibrary.simpleMessage(
      "Reset link sent to your email!",
    ),
    "restoreFailureMessage": MessageLookupByLibrary.simpleMessage(
      "Could not restore purchases or you don\'t have a subscription.",
    ),
    "restoreFromCloud": MessageLookupByLibrary.simpleMessage(
      "Restore from Cloud",
    ),
    "restorePurchases": MessageLookupByLibrary.simpleMessage(
      "Restore Purchases",
    ),
    "sat": MessageLookupByLibrary.simpleMessage("Sat"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saveProfile": MessageLookupByLibrary.simpleMessage("Save Profile"),
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
    "security": MessageLookupByLibrary.simpleMessage("Security"),
    "selectAll": MessageLookupByLibrary.simpleMessage("Select all"),
    "selectAvatar": MessageLookupByLibrary.simpleMessage("Select Avatar"),
    "selectEmoji": MessageLookupByLibrary.simpleMessage("Select Emoji"),
    "selectFrame": MessageLookupByLibrary.simpleMessage("Select Frame"),
    "selectTemplate": MessageLookupByLibrary.simpleMessage("Select Template"),
    "sendFeedbackSubtitle": MessageLookupByLibrary.simpleMessage(
      "We would love to hear from you!",
    ),
    "sendFeedbackTitle": MessageLookupByLibrary.simpleMessage(
      "Send us your feedback",
    ),
    "sendResetLink": MessageLookupByLibrary.simpleMessage("Send Reset Link"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "sevenDays": MessageLookupByLibrary.simpleMessage("7 Days"),
    "sevenWeeks": MessageLookupByLibrary.simpleMessage("7 Weeks"),
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
    "storageAlmostFull": m15,
    "streak": MessageLookupByLibrary.simpleMessage("Streak"),
    "streakDays": m16,
    "streaks": MessageLookupByLibrary.simpleMessage("Streaks"),
    "submitFeedback": MessageLookupByLibrary.simpleMessage("Submit Feedback"),
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
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Terms & Conditions",
    ),
    "termsOfService": MessageLookupByLibrary.simpleMessage("Terms of Service"),
    "termsSec1Content": MessageLookupByLibrary.simpleMessage(
      "By accessing or using Twinfix, you agree to comply with and be bound by these Terms of Service. If you do not agree with any part of these terms, you should immediately cease using the application.",
    ),
    "termsSec1Title": MessageLookupByLibrary.simpleMessage(
      "1. Acceptance of Terms",
    ),
    "termsSec2Content": MessageLookupByLibrary.simpleMessage(
      "Twinfix offers device storage optimization features, including local duplicate image detection, metadata removal, face/watermark blurring, and performance statistics tracking. We provide these services \"as-is\" and reserve the right to modify or discontinue features at any time.",
    ),
    "termsSec2Title": MessageLookupByLibrary.simpleMessage(
      "2. Description of Service",
    ),
    "termsSec3Content": MessageLookupByLibrary.simpleMessage(
      "Certain premium services in Twinfix require active subscriptions or in-app purchases. You are responsible for safeguarding your credentials and payment methods. Subscription processing is securely handled by official store systems (Apple App Store / Google Play).",
    ),
    "termsSec3Title": MessageLookupByLibrary.simpleMessage(
      "3. User Accounts & Subscriptions",
    ),
    "termsSec4Content": MessageLookupByLibrary.simpleMessage(
      "You agree to use Twinfix only for lawful purposes. You must not attempt to reverse-engineer, exploit, hack, or disrupt the operation of the application, local database architectures, or backend synchronization systems.",
    ),
    "termsSec4Title": MessageLookupByLibrary.simpleMessage(
      "4. Permissible Usage",
    ),
    "termsSec5Content": MessageLookupByLibrary.simpleMessage(
      "Twinfix runs photo deletion and cleanup commands directly under user direction. We are not liable for any accidental loss of image files, data corruption, or hardware errors resulting from your configuration or device storage constraints. Please verify any photo deletion selection carefully.",
    ),
    "termsSec5Title": MessageLookupByLibrary.simpleMessage(
      "5. Limitation of Liability",
    ),
    "text": MessageLookupByLibrary.simpleMessage("Text"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "themeSystem": MessageLookupByLibrary.simpleMessage("System"),
    "thu": MessageLookupByLibrary.simpleMessage("Thu"),
    "totalPhotos": m17,
    "totalPhotosLast7Days": m18,
    "totalPhotosLast7Weeks": m19,
    "tue": MessageLookupByLibrary.simpleMessage("Tue"),
    "tune": MessageLookupByLibrary.simpleMessage("Tune"),
    "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "unknownUser": MessageLookupByLibrary.simpleMessage("Unknown User"),
    "upgradeToPremium": MessageLookupByLibrary.simpleMessage(
      "Upgrade to Premium",
    ),
    "vietnamese": MessageLookupByLibrary.simpleMessage("Vietnamese"),
    "viewAllBadges": MessageLookupByLibrary.simpleMessage("View All Badges"),
    "viewDetail": MessageLookupByLibrary.simpleMessage("View detail"),
    "viewFullHistory": MessageLookupByLibrary.simpleMessage(
      "View full history",
    ),
    "watermarkText": MessageLookupByLibrary.simpleMessage("Watermark Text"),
    "website": MessageLookupByLibrary.simpleMessage("Website"),
    "wed": MessageLookupByLibrary.simpleMessage("Wed"),
    "weekShort": MessageLookupByLibrary.simpleMessage("W."),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome Back"),
  };
}

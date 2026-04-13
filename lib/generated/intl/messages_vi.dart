// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
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
  String get localeName => 'vi';

  static String m0(count) => "Bạn đã mở khóa ${count} huy hiệu";

  static String m1(count, total) =>
      "Bạn đã mở khóa ${count} huy hiệu trong tổng số ${total} huy hiệu";

  static String m2(count) => "Tổng số ${count} huy hiệu đã mở khóa";

  static String m3(count, total) =>
      "Bạn đã mở khóa ${count} huy hiệu trong tổng số ${total} huy hiệu";

  static String m4(count) => "Bạn còn ${count} huy hiệu chưa mở khóa";

  static String m5(count, total) =>
      "Bạn còn ${count} huy hiệu chưa mở khóa trong tổng số ${total} huy hiệu";

  static String m6(count) => "Tổng số ${count} huy hiệu chưa mở khóa";

  static String m7(count, total) =>
      "Bạn còn ${count} huy hiệu chưa mở khóa trong tổng số ${total} huy hiệu";

  static String m8(count) => "Tổng số ${count} huy hiệu";

  static String m9(count, total) =>
      "Tổng số ${count} huy hiệu trong tổng số ${total} huy hiệu";

  static String m10(count) =>
      "Bạn có chắc chắn muốn xóa ${count} ảnh này không?";

  static String m11(count) =>
      "Bạn có chắc chắn muốn xóa ${count} ảnh trùng lặp này không?";

  static String m12(count) => "Xóa (${count})";

  static String m13(count) => "Phát hiện ${count} nhóm ảnh tương đồng";

  static String m14(count) => "Phát hiện ${count} ảnh trùng lặp";

  static String m15(message) => "Lỗi: ${message}";

  static String m16(index, count) => "Nhóm ${index} (${count} ảnh)";

  static String m17(level) => "Cấp ${level}";

  static String m18(id) => "ID: ${id}";

  static String m19(percent) =>
      "Dung lượng sắp hết (${percent}%), hãy dọn dẹp ngay!";

  static String m20(days) => "${days} Ngày liên tiếp";

  static String m21(percent) => "Đến cấp tiếp theo (${percent})";

  static String m22(count) => "${count} ảnh";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "achievements": MessageLookupByLibrary.simpleMessage("Thành tựu"),
    "achievementsDescription": MessageLookupByLibrary.simpleMessage(
      "Thu thập tất cả huy hiệu để trở thành bậc thầy dọn dẹp!",
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
    "appearance": MessageLookupByLibrary.simpleMessage("Diện mạo"),
    "back": MessageLookupByLibrary.simpleMessage("Quay lại"),
    "backgroundStyle": MessageLookupByLibrary.simpleMessage("Hình nền"),
    "badges": MessageLookupByLibrary.simpleMessage("Huy hiệu"),
    "bgNature1": MessageLookupByLibrary.simpleMessage("Thuyền rồng"),
    "bgNature2": MessageLookupByLibrary.simpleMessage("Hồ trong rừng"),
    "bgNature3": MessageLookupByLibrary.simpleMessage("Núi Phú Sĩ"),
    "bgNature4": MessageLookupByLibrary.simpleMessage("Hoàng hôn"),
    "bgNone": MessageLookupByLibrary.simpleMessage("Màu đơn"),
    "bgPremium": MessageLookupByLibrary.simpleMessage("Trừu tượng"),
    "cancel": MessageLookupByLibrary.simpleMessage("Hủy"),
    "cleanedData": MessageLookupByLibrary.simpleMessage("Dữ liệu đã dọn"),
    "clearSelection": MessageLookupByLibrary.simpleMessage("Bỏ chọn tất cả"),
    "confirmDelete": MessageLookupByLibrary.simpleMessage("Xác nhận xóa"),
    "confirmDeleteMessage": m10,
    "deepScan": MessageLookupByLibrary.simpleMessage("Quét sâu"),
    "delete": MessageLookupByLibrary.simpleMessage("Xóa"),
    "deleteDuplicates": MessageLookupByLibrary.simpleMessage(
      "Xóa ảnh trùng lặp",
    ),
    "deleteDuplicatesMessage": m11,
    "deleteSelected": m12,
    "detectedDuplicateGroups": m13,
    "detectedDuplicates": m14,
    "deviceIsClean": MessageLookupByLibrary.simpleMessage(
      "Thiết bị của bạn rất sạch sẽ.",
    ),
    "earned": MessageLookupByLibrary.simpleMessage("Đã mở khóa"),
    "english": MessageLookupByLibrary.simpleMessage("Tiếng Anh"),
    "error": m15,
    "galleryManager": MessageLookupByLibrary.simpleMessage("Quản lý ảnh"),
    "general": MessageLookupByLibrary.simpleMessage("Chung"),
    "groupIndex": m16,
    "howToEarn": MessageLookupByLibrary.simpleMessage("Làm sao để đạt được?"),
    "howToEarnDescription": MessageLookupByLibrary.simpleMessage(
      "Bạn cần thực hiện thêm các bước dọn dẹp hệ thống hoặc mời bạn bè để nhận về huy hiệu danh giá này.",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
    "level": m17,
    "longPressToSelectAll": MessageLookupByLibrary.simpleMessage(
      "Nhấn giữ để chọn tất cả",
    ),
    "memoryWarning": MessageLookupByLibrary.simpleMessage("Bộ nhớ sắp đầy!"),
    "noDuplicatesFound": MessageLookupByLibrary.simpleMessage(
      "Không tìm thấy ảnh trùng lặp",
    ),
    "notEarned": MessageLookupByLibrary.simpleMessage(
      "Chưa hoàn thành yêu cầu",
    ),
    "onboardingDemoSwipeLeft": MessageLookupByLibrary.simpleMessage(
      "Vuốt trái để Xóa",
    ),
    "onboardingDemoSwipeRight": MessageLookupByLibrary.simpleMessage(
      "Vuốt phải để Giữ",
    ),
    "onboardingPrivacyMsg": MessageLookupByLibrary.simpleMessage(
      "Tất cả thuật toán đều chạy offline. Dữ liệu của bạn không bao giờ rời khỏi máy!",
    ),
    "onboardingStartScan": MessageLookupByLibrary.simpleMessage(
      "Bắt đầu dọn dẹp",
    ),
    "onboardingWelcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Chào mừng đến với Twinfix",
    ),
    "perfect": MessageLookupByLibrary.simpleMessage("Hoàn hảo!"),
    "photoId": m18,
    "quickScan": MessageLookupByLibrary.simpleMessage("Quét nhanh"),
    "scanResults": MessageLookupByLibrary.simpleMessage("Kết quả quét"),
    "scanningDevice": MessageLookupByLibrary.simpleMessage(
      "Đang quét thiết bị...",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Cài đặt"),
    "storageAlmostFull": m19,
    "streakDays": m20,
    "swipeLeftToDeleteKeepRight": MessageLookupByLibrary.simpleMessage(
      "Vuốt trái để xóa, giữ phải để giữ lại",
    ),
    "tabDashboard": MessageLookupByLibrary.simpleMessage("Thành tựu"),
    "tabScan": MessageLookupByLibrary.simpleMessage("Dọn dẹp"),
    "tabSettings": MessageLookupByLibrary.simpleMessage("Cài đặt"),
    "theme": MessageLookupByLibrary.simpleMessage("Giao diện"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Tối"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Sáng"),
    "themeSystem": MessageLookupByLibrary.simpleMessage("Hệ thống"),
    "toNextLevel": m21,
    "totalPhotos": m22,
    "vietnamese": MessageLookupByLibrary.simpleMessage("Tiếng Việt"),
  };
}

// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
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
  String get localeName => 'vi';

  static String m0(count) =>
      "Bạn có chắc chắn muốn xóa ${count} ảnh này không?";

  static String m1(count) =>
      "Bạn có chắc chắn muốn xóa ${count} ảnh trùng lặp này không?";

  static String m2(count) => "Xóa (${count})";

  static String m3(count) => "Phát hiện ${count} nhóm ảnh tương đồng";

  static String m4(count) => "Phát hiện ${count} ảnh trùng lặp";

  static String m5(message) => "Lỗi: ${message}";

  static String m6(index, count) => "Nhóm ${index} (${count} ảnh)";

  static String m7(level) => "Cấp ${level}";

  static String m8(id) => "ID: ${id}";

  static String m9(percent) =>
      "Dung lượng sắp hết (${percent}%), hãy dọn dẹp ngay!";

  static String m10(days) => "${days} Ngày liên tiếp";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appName": MessageLookupByLibrary.simpleMessage("Twinfix"),
    "back": MessageLookupByLibrary.simpleMessage("Quay lại"),
    "badges": MessageLookupByLibrary.simpleMessage("Huy hiệu"),
    "cancel": MessageLookupByLibrary.simpleMessage("Hủy"),
    "cleanedData": MessageLookupByLibrary.simpleMessage("Dữ liệu đã dọn"),
    "clearSelection": MessageLookupByLibrary.simpleMessage("Bỏ chọn tất cả"),
    "confirmDelete": MessageLookupByLibrary.simpleMessage("Xác nhận xóa"),
    "confirmDeleteMessage": m0,
    "deepScan": MessageLookupByLibrary.simpleMessage("Quét sâu"),
    "delete": MessageLookupByLibrary.simpleMessage("Xóa"),
    "deleteDuplicates": MessageLookupByLibrary.simpleMessage(
      "Xóa ảnh trùng lặp",
    ),
    "deleteDuplicatesMessage": m1,
    "deleteSelected": m2,
    "detectedDuplicateGroups": m3,
    "detectedDuplicates": m4,
    "deviceIsClean": MessageLookupByLibrary.simpleMessage(
      "Thiết bị của bạn rất sạch sẽ.",
    ),
    "error": m5,
    "groupIndex": m6,
    "level": m7,
    "longPressToSelectAll": MessageLookupByLibrary.simpleMessage(
      "Nhấn giữ để chọn tất cả",
    ),
    "memoryWarning": MessageLookupByLibrary.simpleMessage("Bộ nhớ sắp đầy!"),
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
    "photoId": m8,
    "quickScan": MessageLookupByLibrary.simpleMessage("Quét nhanh"),
    "scanningDevice": MessageLookupByLibrary.simpleMessage(
      "Đang quét thiết bị...",
    ),
    "storageAlmostFull": m9,
    "streakDays": m10,
    "swipeLeftToDeleteKeepRight": MessageLookupByLibrary.simpleMessage(
      "Vuốt trái để xóa, giữ phải để giữ lại",
    ),
    "tabDashboard": MessageLookupByLibrary.simpleMessage("Thành tựu"),
    "tabScan": MessageLookupByLibrary.simpleMessage("Dọn dẹp"),
  };
}

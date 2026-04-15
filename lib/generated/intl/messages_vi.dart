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

  static String m10(size) => "Đã dọn dẹp thành công ${size}";

  static String m11(count) =>
      "Bạn có chắc chắn muốn xóa ${count} ảnh này không? Ảnh sẽ được chuyển vào Thùng rác hệ thống. Bạn cần dọn sạch thùng rác để giải phóng hoàn toàn bộ nhớ.";

  static String m12(count) =>
      "Bạn có chắc chắn muốn xóa ${count} ảnh trùng lặp này không? Ảnh sẽ được chuyển vào Thùng rác hệ thống.";

  static String m13(count) => "Xóa (${count})";

  static String m14(count) => "Xóa ${count} ảnh đã chọn";

  static String m15(count) =>
      "Bạn có chắc chắn muốn xóa ${count} ảnh đã chọn? Ảnh sẽ được chuyển vào Thùng rác hệ thống. Bạn cần dọn sạch thùng rác để giải phóng hoàn toàn bộ nhớ.";

  static String m16(count) => "Xóa thành công ${count} ảnh";

  static String m17(count) => "Phát hiện ${count} nhóm ảnh tương đồng";

  static String m18(count) => "Phát hiện ${count} ảnh trùng lặp";

  static String m19(message) => "Lỗi: ${message}";

  static String m20(index, count) => "Nhóm ${index} (${count} ảnh)";

  static String m21(level) => "Cấp ${level}";

  static String m22(email) => "Đã đăng nhập: ${email}";

  static String m23(id) => "ID: ${id}";

  static String m24(percent) =>
      "Dung lượng sắp hết (${percent}%), hãy dọn dẹp ngay!";

  static String m25(days) => "${days} Ngày liên tiếp";

  static String m26(percent) => "Đến cấp tiếp theo (${percent})";

  static String m27(count) => "${count} ảnh";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "account": MessageLookupByLibrary.simpleMessage("Tài khoản"),
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
    "calculatingProgress": MessageLookupByLibrary.simpleMessage(
      "Đang tính toán...",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Hủy"),
    "cleanedData": MessageLookupByLibrary.simpleMessage("Dữ liệu đã dọn"),
    "cleanedSpaceSuccess": m10,
    "clearSelection": MessageLookupByLibrary.simpleMessage("Bỏ chọn tất cả"),
    "confirmDelete": MessageLookupByLibrary.simpleMessage("Xác nhận xóa"),
    "confirmDeleteMessage": m11,
    "dateAsc": MessageLookupByLibrary.simpleMessage("Ngày tăng dần"),
    "dateDesc": MessageLookupByLibrary.simpleMessage("Ngày giảm dần"),
    "deepScan": MessageLookupByLibrary.simpleMessage("Quét sâu"),
    "delete": MessageLookupByLibrary.simpleMessage("Xóa"),
    "deleteDuplicates": MessageLookupByLibrary.simpleMessage(
      "Xóa ảnh trùng lặp",
    ),
    "deleteDuplicatesMessage": m12,
    "deleteSelected": m13,
    "deleteSelectedPhotos": m14,
    "deleteSelectedPhotosMessage": m15,
    "deleteSuccess": m16,
    "delete_confirm_message": MessageLookupByLibrary.simpleMessage(
      "Hãy kiểm tra kỹ lần cuối!\nBạn không thể hoàn tác đâu nhé!",
    ),
    "detectedDuplicateGroups": m17,
    "detectedDuplicates": m18,
    "deviceIsClean": MessageLookupByLibrary.simpleMessage(
      "Thiết bị của bạn rất sạch sẽ.",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Đã hiểu"),
    "earned": MessageLookupByLibrary.simpleMessage("Đã mở khóa"),
    "english": MessageLookupByLibrary.simpleMessage("Tiếng Anh"),
    "error": m19,
    "galleryManager": MessageLookupByLibrary.simpleMessage("Quản lý ảnh"),
    "general": MessageLookupByLibrary.simpleMessage("Chung"),
    "groupIndex": m20,
    "howToEarn": MessageLookupByLibrary.simpleMessage("Làm sao để đạt được?"),
    "howToEarnDescription": MessageLookupByLibrary.simpleMessage(
      "Bạn cần thực hiện thêm các bước dọn dẹp hệ thống hoặc mời bạn bè để nhận về huy hiệu danh giá này.",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
    "level": m21,
    "loggedInAs": m22,
    "login": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
    "loginToSync": MessageLookupByLibrary.simpleMessage(
      "Đăng nhập để đồng bộ tiến trình của bạn",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
    "longPressToSelectAll": MessageLookupByLibrary.simpleMessage(
      "Nhấn giữ để chọn tất cả",
    ),
    "media_audio": MessageLookupByLibrary.simpleMessage("Âm thanh"),
    "media_document": MessageLookupByLibrary.simpleMessage("Tài liệu"),
    "media_other": MessageLookupByLibrary.simpleMessage("Khác"),
    "media_photo": MessageLookupByLibrary.simpleMessage("Ảnh"),
    "media_type_selection": MessageLookupByLibrary.simpleMessage(
      "Chọn loại phương tiện",
    ),
    "media_video": MessageLookupByLibrary.simpleMessage("Video"),
    "memoryWarning": MessageLookupByLibrary.simpleMessage("Bộ nhớ sắp đầy!"),
    "mergeData": MessageLookupByLibrary.simpleMessage("Kết hợp dữ liệu"),
    "nameAsc": MessageLookupByLibrary.simpleMessage("Tên tăng dần"),
    "nameDesc": MessageLookupByLibrary.simpleMessage("Tên giảm dần"),
    "next": MessageLookupByLibrary.simpleMessage("Tiếp theo"),
    "noDuplicatesFound": MessageLookupByLibrary.simpleMessage(
      "Không tìm thấy ảnh trùng lặp",
    ),
    "notEarned": MessageLookupByLibrary.simpleMessage(
      "Chưa hoàn thành yêu cầu",
    ),
    "notLoggedIn": MessageLookupByLibrary.simpleMessage(
      "Chưa đăng nhập (Khách)",
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
    "openGalleryManager": MessageLookupByLibrary.simpleMessage(
      "Mở Gallery Manager",
    ),
    "openGalleryManagerDescription": MessageLookupByLibrary.simpleMessage(
      "Nếu muốn dọn thủ công theo từng loại media, hãy vào đây. Chạm nút được highlight để mở luôn.",
    ),
    "or": MessageLookupByLibrary.simpleMessage("Hoặc"),
    "perfect": MessageLookupByLibrary.simpleMessage("Hoàn hảo!"),
    "photoId": m23,
    "progress": MessageLookupByLibrary.simpleMessage("Tiến trình"),
    "quickScan": MessageLookupByLibrary.simpleMessage("Quét nhanh"),
    "scanResults": MessageLookupByLibrary.simpleMessage("Kết quả quét"),
    "scanningDevice": MessageLookupByLibrary.simpleMessage(
      "Đang quét thiết bị...",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Cài đặt"),
    "sizeAsc": MessageLookupByLibrary.simpleMessage("Kích thước tăng dần"),
    "sizeDesc": MessageLookupByLibrary.simpleMessage("Kích thước giảm dần"),
    "skip": MessageLookupByLibrary.simpleMessage("Bỏ qua"),
    "sort": MessageLookupByLibrary.simpleMessage("Sắp xếp"),
    "startFresh": MessageLookupByLibrary.simpleMessage("Bắt đầu mới"),
    "startQuickScan": MessageLookupByLibrary.simpleMessage(
      "Bắt đầu quét nhanh",
    ),
    "startQuickScanDescription": MessageLookupByLibrary.simpleMessage(
      "Nút này dùng để quét thư viện và tìm ảnh trùng chỉ với vài thao tác.",
    ),
    "stats": MessageLookupByLibrary.simpleMessage("Thống kê"),
    "storageAlmostFull": m24,
    "streakDays": m25,
    "streaks": MessageLookupByLibrary.simpleMessage("Chuỗi ngày"),
    "swipeLeftToDeleteKeepRight": MessageLookupByLibrary.simpleMessage(
      "Vuốt trái để xóa, giữ phải để giữ lại",
    ),
    "syncDataMessage": MessageLookupByLibrary.simpleMessage(
      "Chúng tôi thấy bạn có dữ liệu dọn dẹp cũ từ phiên làm việc khách. Bạn có muốn kết hợp chúng vào tài khoản mới này không?",
    ),
    "syncDataTitle": MessageLookupByLibrary.simpleMessage(
      "Liên kết dữ liệu khách?",
    ),
    "tabDashboard": MessageLookupByLibrary.simpleMessage("Thành tựu"),
    "tabOtherFeatures": MessageLookupByLibrary.simpleMessage("Khác"),
    "tabScan": MessageLookupByLibrary.simpleMessage("Dọn dẹp"),
    "tabSettings": MessageLookupByLibrary.simpleMessage("Cài đặt"),
    "theme": MessageLookupByLibrary.simpleMessage("Giao diện"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Tối"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Sáng"),
    "themeSystem": MessageLookupByLibrary.simpleMessage("Hệ thống"),
    "toNextLevel": m26,
    "totalPhotos": m27,
    "vietnamese": MessageLookupByLibrary.simpleMessage("Tiếng Việt"),
  };
}

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

  static String m0(version) => "Phiên bản ${version}";

  static String m1(num, unit, size) =>
      "Đã dọn dẹp thành công ${num} ${unit} (${size})";

  static String m2(badgeName) => "Bạn vừa đạt được huy hiệu \"${badgeName}\"!";

  static String m3(count) => "Bạn vừa đạt được ${count} huy hiệu mới!";

  static String m4(email) =>
      "Không thể mở ứng dụng Email. Email hỗ trợ: ${email}";

  static String m5(count) => "Xóa (${count})";

  static String m6(count) => "Xóa ${count} ảnh đã chọn";

  static String m7(count) =>
      "Bạn có chắc chắn muốn xóa ${count} ảnh đã chọn? Ảnh sẽ được chuyển vào Thùng rác hệ thống. Bạn cần dọn sạch thùng rác để giải phóng hoàn toàn bộ nhớ.";

  static String m8(count, size) => "Xóa (${count}) • ${size}";

  static String m9(count) => "Đã xóa ${count} ảnh";

  static String m10(count) => "Phát hiện ${count} nhóm ảnh tương đồng";

  static String m11(message) => "Lỗi: ${message}";

  static String m12(index, count) => "Nhóm ${index} (${count} ảnh)";

  static String m13(date) => "Cập nhật lần cuối: ${date}";

  static String m14(level) => "Cấp ${level}";

  static String m15(percent) =>
      "Dung lượng sắp hết (${percent}%), hãy dọn dẹp ngay!";

  static String m16(days) => "${days} Ngày liên tiếp";

  static String m17(count) => "${count} ảnh";

  static String m18(count, mediaType) =>
      "Tổng: ${count} ${mediaType} (7 ngày qua)";

  static String m19(count, mediaType) =>
      "Tổng: ${count} ${mediaType} (7 tuần qua)";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutDescription": MessageLookupByLibrary.simpleMessage(
      "Twinfix is a công cụ mạnh mẽ được thiết kế để giúp bạn sắp xếp và dọn dẹp thư viện ảnh một cách dễ dàng bằng AI.",
    ),
    "aboutUs": MessageLookupByLibrary.simpleMessage("Về chúng tôi"),
    "account": MessageLookupByLibrary.simpleMessage("Tài khoản"),
    "accountSyncActive": MessageLookupByLibrary.simpleMessage(
      "Đã kích hoạt đồng bộ tài khoản",
    ),
    "activity": MessageLookupByLibrary.simpleMessage("Hoạt động"),
    "activityDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Chi tiết hoạt động",
    ),
    "addWaterMark": MessageLookupByLibrary.simpleMessage("Thêm Watermark"),
    "addWaterMarkDescription": MessageLookupByLibrary.simpleMessage(
      "Thêm watermark vào ảnh.",
    ),
    "allBadges": MessageLookupByLibrary.simpleMessage("Tất cả huy hiệu"),
    "alreadyHaveAccountLogin": MessageLookupByLibrary.simpleMessage(
      "Đã có tài khoản? Đăng nhập",
    ),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "Photo Duplicate Cleaner",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("Twinfix"),
    "appVersion": m0,
    "appearance": MessageLookupByLibrary.simpleMessage("Diện mạo"),
    "awesome": MessageLookupByLibrary.simpleMessage("Tuyệt vời!"),
    "back": MessageLookupByLibrary.simpleMessage("Quay lại"),
    "backgroundStyle": MessageLookupByLibrary.simpleMessage("Hình nền"),
    "badgeAiCleanerDesc": MessageLookupByLibrary.simpleMessage(
      "Sử dụng tính năng dọn dẹp tự động.",
    ),
    "badgeAiCleanerName": MessageLookupByLibrary.simpleMessage("Trợ thủ AI"),
    "badgeBlurry10Desc": MessageLookupByLibrary.simpleMessage("Xóa 10 ảnh mờ."),
    "badgeBlurry10Name": MessageLookupByLibrary.simpleMessage("Thợ săn ảnh mờ"),
    "badgeBlurry200Desc": MessageLookupByLibrary.simpleMessage(
      "Xóa 200 ảnh mờ.",
    ),
    "badgeBlurry200Name": MessageLookupByLibrary.simpleMessage(
      "Kẻ hủy diệt ảnh mờ",
    ),
    "badgeBlurryKillerDesc": MessageLookupByLibrary.simpleMessage(
      "Xóa 50 ảnh mờ.",
    ),
    "badgeBlurryKillerName": MessageLookupByLibrary.simpleMessage(
      "Sát thủ ảnh mờ",
    ),
    "badgeCleaner1000Desc": MessageLookupByLibrary.simpleMessage(
      "Xóa tổng cộng 1000 ảnh.",
    ),
    "badgeCleaner1000Name": MessageLookupByLibrary.simpleMessage(
      "Máy nghiền ảnh",
    ),
    "badgeCleaner100Desc": MessageLookupByLibrary.simpleMessage(
      "Xóa tổng cộng 100 ảnh.",
    ),
    "badgeCleaner100Name": MessageLookupByLibrary.simpleMessage(
      "Chuyên gia dọn dẹp",
    ),
    "badgeCleaner10Desc": MessageLookupByLibrary.simpleMessage(
      "Xóa tổng cộng 10 ảnh.",
    ),
    "badgeCleaner10Name": MessageLookupByLibrary.simpleMessage(
      "Tập sự dọn dẹp",
    ),
    "badgeDuplicate100Desc": MessageLookupByLibrary.simpleMessage(
      "Xóa 100 ảnh trùng lặp.",
    ),
    "badgeDuplicate100Name": MessageLookupByLibrary.simpleMessage(
      "Bậc thầy ảnh trùng",
    ),
    "badgeDuplicate20Desc": MessageLookupByLibrary.simpleMessage(
      "Xóa 20 ảnh trùng lặp.",
    ),
    "badgeDuplicate20Name": MessageLookupByLibrary.simpleMessage(
      "Thợ săn ảnh trùng",
    ),
    "badgeFirstCleanDesc": MessageLookupByLibrary.simpleMessage(
      "Xóa những bức ảnh đầu tiên.",
    ),
    "badgeFirstCleanName": MessageLookupByLibrary.simpleMessage(
      "Phát dọn lần đầu",
    ),
    "badgeFreed100mbDesc": MessageLookupByLibrary.simpleMessage(
      "Xóa tổng cộng 200 ảnh.",
    ),
    "badgeFreed100mbName": MessageLookupByLibrary.simpleMessage(
      "Tập sự dọn dẹp (Cấp 2)",
    ),
    "badgeFreed10gbDesc": MessageLookupByLibrary.simpleMessage(
      "Xóa tổng cộng 5000 ảnh.",
    ),
    "badgeFreed10gbName": MessageLookupByLibrary.simpleMessage(
      "Huyền thoại dọn dẹp",
    ),
    "badgeFreed5gbDesc": MessageLookupByLibrary.simpleMessage(
      "Xóa tổng cộng 2000 ảnh.",
    ),
    "badgeFreed5gbName": MessageLookupByLibrary.simpleMessage(
      "Anh hùng dọn dẹp",
    ),
    "badgeGigaKingDesc": MessageLookupByLibrary.simpleMessage(
      "Xóa tổng cộng 500 ảnh.",
    ),
    "badgeGigaKingName": MessageLookupByLibrary.simpleMessage(
      "Bậc thầy dọn dẹp",
    ),
    "badgeNewbieDesc": MessageLookupByLibrary.simpleMessage(
      "Xóa ảnh lần đầu tiên và bắt đầu cuộc hành trình giải cứu bộ nhớ.",
    ),
    "badgeNewbieName": MessageLookupByLibrary.simpleMessage(
      "Người mới dọn dẹp",
    ),
    "badgePerfectionistDesc": MessageLookupByLibrary.simpleMessage(
      "Xóa hơn 80% ảnh mờ trong thiết bị.",
    ),
    "badgePerfectionistName": MessageLookupByLibrary.simpleMessage(
      "Người cầu toàn",
    ),
    "badgeSpeedCleanDesc": MessageLookupByLibrary.simpleMessage(
      "Xóa 50 ảnh trong một lần.",
    ),
    "badgeSpeedCleanName": MessageLookupByLibrary.simpleMessage(
      "Dọn dẹp thần tốc",
    ),
    "badgeStreak3Desc": MessageLookupByLibrary.simpleMessage(
      "Dọn dẹp 3 ngày liên tiếp.",
    ),
    "badgeStreak3Name": MessageLookupByLibrary.simpleMessage("Chăm chỉ"),
    "badgeStreak7Desc": MessageLookupByLibrary.simpleMessage(
      "Dọn dẹp 7 ngày liên tiếp.",
    ),
    "badgeStreak7Name": MessageLookupByLibrary.simpleMessage("Không bỏ cuộc"),
    "badges": MessageLookupByLibrary.simpleMessage("Huy hiệu"),
    "becomeOneOfUs": MessageLookupByLibrary.simpleMessage(
      "Hãy là một phần của chúng tôi",
    ),
    "blur": MessageLookupByLibrary.simpleMessage("Làm mờ"),
    "blurFace": MessageLookupByLibrary.simpleMessage("Ẩn khuôn mặt"),
    "blurFaceDescription": MessageLookupByLibrary.simpleMessage(
      "Ẩn khuôn mặt khỏi ảnh.",
    ),
    "blurryDeleted": MessageLookupByLibrary.simpleMessage("Đã xóa ảnh mờ"),
    "blurryPhotos": MessageLookupByLibrary.simpleMessage("Ảnh mờ"),
    "blurryPhotosDescription": MessageLookupByLibrary.simpleMessage(
      "Ảnh mờ là ảnh bị mờ, không rõ nét. Hãy dọn dẹp chúng để giải phóng dung lượng.",
    ),
    "calculatingProgress": MessageLookupByLibrary.simpleMessage(
      "Đang tính toán...",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Hủy"),
    "cancelMonthlyMessage": MessageLookupByLibrary.simpleMessage(
      "Bạn đã nâng cấp Trọn đời thành công! Vì bạn đang sử dụng gói Tháng, vui lòng vào Cửa hàng ứng dụng (App Store/Google Play) để HỦY gói Tháng, tránh bị trừ tiền vào chu kỳ tới.",
    ),
    "cancelMonthlyTitle": MessageLookupByLibrary.simpleMessage(
      "Hành động cần thiết",
    ),
    "changeFrame": MessageLookupByLibrary.simpleMessage("Đổi khung"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Đổi mật khẩu"),
    "changePasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Đổi mật khẩu thành công",
    ),
    "cleaned": MessageLookupByLibrary.simpleMessage("Đã dọn"),
    "cleanedData": MessageLookupByLibrary.simpleMessage("Dữ liệu đã dọn"),
    "cleanedSpaceSuccess": m1,
    "clearSelection": MessageLookupByLibrary.simpleMessage("Bỏ chọn tất cả"),
    "confirmDelete": MessageLookupByLibrary.simpleMessage("Xác nhận xóa"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Xác nhận mật khẩu",
    ),
    "confirmPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Xác nhận mật khẩu không được để trống",
    ),
    "confirmnoMorePhotosToDelete": MessageLookupByLibrary.simpleMessage(
      "Không còn ảnh nào để xoá",
    ),
    "congratsBadgeMessage": m2,
    "congratsBadgeTitle": MessageLookupByLibrary.simpleMessage("Huy hiệu mới!"),
    "congratsMultipleBadgesMessage": m3,
    "contactUs": MessageLookupByLibrary.simpleMessage("Liên hệ với chúng tôi"),
    "continueWithFreeVersion": MessageLookupByLibrary.simpleMessage(
      "Tiếp tục với phiên bản miễn phí",
    ),
    "contributionGraph": MessageLookupByLibrary.simpleMessage(
      "Biểu đồ đóng góp",
    ),
    "convertImageFailed": MessageLookupByLibrary.simpleMessage(
      "Không thể chuyển đổi ảnh",
    ),
    "couldNotDecodeImage": MessageLookupByLibrary.simpleMessage(
      "Không thể giải mã ảnh",
    ),
    "couldNotOpenEmailApp": m4,
    "createAccount": MessageLookupByLibrary.simpleMessage("Tạo tài khoản mới"),
    "createNewImage": MessageLookupByLibrary.simpleMessage("Tạo ảnh mới"),
    "crop": MessageLookupByLibrary.simpleMessage("Cắt"),
    "currentPlan": MessageLookupByLibrary.simpleMessage("Gói Hiện Tại"),
    "dataSynchronizedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Đã đồng bộ dữ liệu thành công",
    ),
    "dateAsc": MessageLookupByLibrary.simpleMessage("Ngày tăng dần"),
    "dateDesc": MessageLookupByLibrary.simpleMessage("Ngày giảm dần"),
    "days": MessageLookupByLibrary.simpleMessage("Ngày"),
    "delete": MessageLookupByLibrary.simpleMessage("Xóa"),
    "deleteSelected": m5,
    "deleteSelectedPhotos": m6,
    "deleteSelectedPhotosMessage": m7,
    "deleteSelectedWithCountAndSize": m8,
    "delete_confirm_message": MessageLookupByLibrary.simpleMessage(
      "Hãy kiểm tra kỹ lần cuối!\nBạn không thể hoàn tác đâu nhé!",
    ),
    "deletedItemsCount": m9,
    "density": MessageLookupByLibrary.simpleMessage("Mật độ"),
    "detectedDuplicateGroups": m10,
    "deviceIsClean": MessageLookupByLibrary.simpleMessage(
      "Thiết bị của bạn rất sạch sẽ.",
    ),
    "document": MessageLookupByLibrary.simpleMessage("Phát hiện tài liệu"),
    "documentDescription": MessageLookupByLibrary.simpleMessage(
      "Nhận diện và quản lý các ảnh có chứa văn bản.",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Đã hiểu"),
    "duplicates": MessageLookupByLibrary.simpleMessage("Ảnh trùng lặp"),
    "earned": MessageLookupByLibrary.simpleMessage("Đã mở khóa"),
    "edit": MessageLookupByLibrary.simpleMessage("Chỉnh sửa"),
    "editAnotherPhoto": MessageLookupByLibrary.simpleMessage("Sửa ảnh khác"),
    "editDescription": MessageLookupByLibrary.simpleMessage("Chỉnh sửa ảnh"),
    "effectBlur": MessageLookupByLibrary.simpleMessage("Làm mờ"),
    "effectEmoji": MessageLookupByLibrary.simpleMessage("Emoji"),
    "effectPixelate": MessageLookupByLibrary.simpleMessage("Dạng Pixel"),
    "effectSolid": MessageLookupByLibrary.simpleMessage("Màu đặc"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emailInvalid": MessageLookupByLibrary.simpleMessage(
      "Định dạng email không hợp lệ",
    ),
    "emailRequired": MessageLookupByLibrary.simpleMessage(
      "Email không được để trống",
    ),
    "emoji": MessageLookupByLibrary.simpleMessage("Emoji"),
    "english": MessageLookupByLibrary.simpleMessage("Tiếng Anh"),
    "enterWatermarkText": MessageLookupByLibrary.simpleMessage(
      "Nhập văn bản watermark",
    ),
    "error": m11,
    "errorEmailNotFound": MessageLookupByLibrary.simpleMessage(
      "Email hỗ trợ không được tìm thấy",
    ),
    "error_unable_to_play_media": MessageLookupByLibrary.simpleMessage(
      "Không thể phát media",
    ),
    "error_unsupported_media_type": MessageLookupByLibrary.simpleMessage(
      "Không hỗ trợ loại media này",
    ),
    "eyeBar": MessageLookupByLibrary.simpleMessage("Thanh che mắt"),
    "failedToSendResetLink": MessageLookupByLibrary.simpleMessage(
      "Gửi liên kết đặt lại mật khẩu thất bại",
    ),
    "featureClean": MessageLookupByLibrary.simpleMessage("Dọn dẹp hiệu quả"),
    "featureMascot": MessageLookupByLibrary.simpleMessage(
      "Hỗ trợ từ Linh vật thân thiện",
    ),
    "featureModernUI": MessageLookupByLibrary.simpleMessage(
      "Giao diện hiện đại",
    ),
    "featureScan": MessageLookupByLibrary.simpleMessage("Quét nhanh chóng"),
    "featuresTitle": MessageLookupByLibrary.simpleMessage("Tính năng chính"),
    "feedbackContentHint": MessageLookupByLibrary.simpleMessage(
      "Nhập mô tả chi tiết lỗi hoặc đề xuất cải tiến của bạn tại đây...",
    ),
    "feedbackContentLabel": MessageLookupByLibrary.simpleMessage(
      "Nội dung chi tiết",
    ),
    "feedbackContentRequired": MessageLookupByLibrary.simpleMessage(
      "Vui lòng nhập nội dung chi tiết",
    ),
    "feedbackTitleHint": MessageLookupByLibrary.simpleMessage(
      "Nhập tiêu đề phản hồi...",
    ),
    "feedbackTitleLabel": MessageLookupByLibrary.simpleMessage("Tiêu đề"),
    "feedbackTitleRequired": MessageLookupByLibrary.simpleMessage(
      "Vui lòng nhập tiêu đề",
    ),
    "feedbackTypeBug": MessageLookupByLibrary.simpleMessage("Lỗi (Bug)"),
    "feedbackTypeImprovement": MessageLookupByLibrary.simpleMessage(
      "Gợi ý (Improvement)",
    ),
    "feedbackTypeLabel": MessageLookupByLibrary.simpleMessage("Loại phản hồi"),
    "feedbackTypeOther": MessageLookupByLibrary.simpleMessage("Khác (Other)"),
    "feedbackTypeQuestion": MessageLookupByLibrary.simpleMessage(
      "Câu hỏi (Question)",
    ),
    "file": MessageLookupByLibrary.simpleMessage("tệp"),
    "files": MessageLookupByLibrary.simpleMessage("tệp"),
    "filter": MessageLookupByLibrary.simpleMessage("Bộ lọc"),
    "finish": MessageLookupByLibrary.simpleMessage("Hoàn tất"),
    "footerTitle": MessageLookupByLibrary.simpleMessage(
      "Liên hệ với chúng tôi",
    ),
    "forgotPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Nhập địa chỉ email của bạn và chúng tôi sẽ gửi cho bạn một liên kết để đặt lại mật khẩu.",
    ),
    "forgotPasswordQuestion": MessageLookupByLibrary.simpleMessage(
      "Quên mật khẩu?",
    ),
    "forgotPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Quên mật khẩu",
    ),
    "freePlan": MessageLookupByLibrary.simpleMessage("Gói Miễn phí"),
    "fri": MessageLookupByLibrary.simpleMessage("Th 6"),
    "fullName": MessageLookupByLibrary.simpleMessage("Họ và tên"),
    "galleryManager": MessageLookupByLibrary.simpleMessage("Quản lý ảnh"),
    "general": MessageLookupByLibrary.simpleMessage("Chung"),
    "glasses": MessageLookupByLibrary.simpleMessage("Kính râm"),
    "googleLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Đăng nhập bằng Google thất bại. Vui lòng thử lại.",
    ),
    "googleLoginSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Đăng nhập bằng Google thành công!",
    ),
    "gpsRemovedSuccess": MessageLookupByLibrary.simpleMessage(
      "Đã xóa dữ liệu vị trí và lưu thành bản sao mới.",
    ),
    "grantPermission": MessageLookupByLibrary.simpleMessage("Cấp quyền"),
    "groupIndex": m12,
    "history": MessageLookupByLibrary.simpleMessage("Lịch sử"),
    "historyEarlier": MessageLookupByLibrary.simpleMessage("Cũ hơn"),
    "historyLast7Days": MessageLookupByLibrary.simpleMessage("7 ngày qua"),
    "historyThisMonth": MessageLookupByLibrary.simpleMessage("Tháng này"),
    "historyToday": MessageLookupByLibrary.simpleMessage("Hôm nay"),
    "historyYesterday": MessageLookupByLibrary.simpleMessage("Hôm qua"),
    "howToEarn": MessageLookupByLibrary.simpleMessage("Làm sao để đạt được?"),
    "howToEarnDescription": MessageLookupByLibrary.simpleMessage(
      "Bạn cần thực hiện thêm các bước dọn dẹp hệ thống hoặc mời bạn bè để nhận về huy hiệu danh giá này.",
    ),
    "imageSaved": MessageLookupByLibrary.simpleMessage(
      "Đã lưu ảnh thành công!",
    ),
    "includedInLifetime": MessageLookupByLibrary.simpleMessage(
      "Đã bao gồm trong Trọn Đời",
    ),
    "intensity": MessageLookupByLibrary.simpleMessage("Độ đậm nhạt"),
    "itemsDeleted": MessageLookupByLibrary.simpleMessage("Ảnh đã xoá"),
    "keepLocalData": MessageLookupByLibrary.simpleMessage(
      "Giữ dữ liệu trên máy",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
    "lastUpdatedDate": m13,
    "less": MessageLookupByLibrary.simpleMessage("ít"),
    "level": m14,
    "livePhotos": MessageLookupByLibrary.simpleMessage("Ảnh Live"),
    "livePhotosDescription": MessageLookupByLibrary.simpleMessage(
      "Ảnh Live là ảnh động, có thể phát lại video ngắn. Hãy dọn dẹp chúng để giải phóng dung lượng.",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
    "loginFailureMessage": MessageLookupByLibrary.simpleMessage(
      "Đăng nhập thất bại. Vui lòng thử lại.",
    ),
    "loginSuccess": MessageLookupByLibrary.simpleMessage(
      "Đăng nhập thành công",
    ),
    "loginSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Đăng nhập thành công!",
    ),
    "loginToSync": MessageLookupByLibrary.simpleMessage(
      "Đăng nhập để đồng bộ tiến trình của bạn",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
    "longPressToSelectAll": MessageLookupByLibrary.simpleMessage(
      "Nhấn giữ để chọn tất cả",
    ),
    "manageSubscriptions": MessageLookupByLibrary.simpleMessage(
      "Quản lý Đăng ký",
    ),
    "mask": MessageLookupByLibrary.simpleMessage("Mặt nạ"),
    "mediaInfo": MessageLookupByLibrary.simpleMessage("Thông tin media"),
    "media_audio": MessageLookupByLibrary.simpleMessage("Âm thanh"),
    "media_other": MessageLookupByLibrary.simpleMessage("Khác"),
    "media_photo": MessageLookupByLibrary.simpleMessage("Ảnh"),
    "media_type_selection": MessageLookupByLibrary.simpleMessage(
      "Chọn loại phương tiện",
    ),
    "media_video": MessageLookupByLibrary.simpleMessage("Video"),
    "memoryWarning": MessageLookupByLibrary.simpleMessage("Bộ nhớ sắp đầy!"),
    "mergeData": MessageLookupByLibrary.simpleMessage("Kết hợp dữ liệu"),
    "mon": MessageLookupByLibrary.simpleMessage("Th 2"),
    "more": MessageLookupByLibrary.simpleMessage("nhiều"),
    "nameLength": MessageLookupByLibrary.simpleMessage(
      "Tên phải có ít nhất 2 ký tự",
    ),
    "nameRequired": MessageLookupByLibrary.simpleMessage(
      "Tên không được để trống",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Mật khẩu mới"),
    "next": MessageLookupByLibrary.simpleMessage("Tiếp theo"),
    "noAccountRegister": MessageLookupByLibrary.simpleMessage(
      "Chưa có tài khoản? Đăng ký ngay",
    ),
    "noActivity": MessageLookupByLibrary.simpleMessage(
      "Chưa có hoạt động dọn dẹp nào",
    ),
    "noBadgesEarnedYet": MessageLookupByLibrary.simpleMessage(
      "Chưa có huy hiệu",
    ),
    "noDocumentsFound": MessageLookupByLibrary.simpleMessage(
      "Không tìm thấy ảnh có chứa văn bản.",
    ),
    "noDuplicatesFound": MessageLookupByLibrary.simpleMessage(
      "Không tìm thấy ảnh trùng lặp",
    ),
    "noEmailProvided": MessageLookupByLibrary.simpleMessage(
      "Chưa cung cấp email",
    ),
    "noFacesDetected": MessageLookupByLibrary.simpleMessage(
      "Không phát hiện khuôn mặt nào trong ảnh.",
    ),
    "noPhotosWithGPSFound": MessageLookupByLibrary.simpleMessage(
      "Không tìm thấy ảnh có chứa dữ liệu vị trí.",
    ),
    "notEarned": MessageLookupByLibrary.simpleMessage(
      "Chưa hoàn thành yêu cầu",
    ),
    "notLoggedIn": MessageLookupByLibrary.simpleMessage(
      "Chưa đăng nhập (Khách)",
    ),
    "nothingFound": MessageLookupByLibrary.simpleMessage("Không tìm thấy gì"),
    "ok": MessageLookupByLibrary.simpleMessage("Đồng ý"),
    "oldPassword": MessageLookupByLibrary.simpleMessage("Mật khẩu cũ"),
    "onboardingDemoSwipeLeft": MessageLookupByLibrary.simpleMessage(
      "Vuốt trái để Xóa",
    ),
    "onboardingDemoSwipeRight": MessageLookupByLibrary.simpleMessage(
      "Vuốt phải để Giữ",
    ),
    "onboardingStartScan": MessageLookupByLibrary.simpleMessage(
      "Bắt đầu dọn dẹp",
    ),
    "onboardingWelcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Chào mừng đến với Twinfix",
    ),
    "opacity": MessageLookupByLibrary.simpleMessage("Đậm nhạt"),
    "openGalleryManager": MessageLookupByLibrary.simpleMessage(
      "Mở Gallery Manager",
    ),
    "openGalleryManagerDescription": MessageLookupByLibrary.simpleMessage(
      "Nếu muốn dọn thủ công theo từng loại media, hãy vào đây. Chạm nút được highlight để mở luôn.",
    ),
    "openSettings": MessageLookupByLibrary.simpleMessage("Mở cài đặt"),
    "openingEmailApp": MessageLookupByLibrary.simpleMessage(
      "Đang mở ứng dụng Email để gửi phản hồi...",
    ),
    "or": MessageLookupByLibrary.simpleMessage("Hoặc"),
    "packageFreeDescription": MessageLookupByLibrary.simpleMessage(
      "Phiên bản có quảng cáo & giới hạn tính năng",
    ),
    "packageFreePrice": MessageLookupByLibrary.simpleMessage("0đ"),
    "packageFreeTitle": MessageLookupByLibrary.simpleMessage("Miễn phí"),
    "packageLifetimeDescription": MessageLookupByLibrary.simpleMessage(
      "Mua 1 lần dùng mãi mãi.",
    ),
    "packageLifetimeTitle": MessageLookupByLibrary.simpleMessage("Trọn Đời"),
    "packageMonthlyDescription": MessageLookupByLibrary.simpleMessage(
      "Đăng ký hàng tháng. Hủy bất cứ lúc nào.",
    ),
    "packageMonthlyTitle": MessageLookupByLibrary.simpleMessage("1 Tháng"),
    "paint": MessageLookupByLibrary.simpleMessage("Vẽ"),
    "password": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
    "passwordLength": MessageLookupByLibrary.simpleMessage(
      "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt",
    ),
    "passwordRequired": MessageLookupByLibrary.simpleMessage(
      "Mật khẩu không được để trống",
    ),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage(
      "Mật khẩu quá ngắn",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Mật khẩu không trùng khớp",
    ),
    "paywallSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tận hưởng mọi tính năng chuyên nghiệp mà không bị giới hạn.",
    ),
    "paywallTitle": MessageLookupByLibrary.simpleMessage("Mở Khóa Premium"),
    "paywallWelcomeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Khai phá toàn bộ tiềm năng thư viện ảnh của bạn với các công cụ AI mạnh mẽ và trải nghiệm không quảng cáo.",
    ),
    "paywallWelcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Chào mừng bạn đến với Premium",
    ),
    "perfect": MessageLookupByLibrary.simpleMessage("Hoàn hảo!"),
    "permissionDescription": MessageLookupByLibrary.simpleMessage(
      "Twinfix cần quyền truy cập vào thư viện ảnh để quét và dọn dẹp các ảnh trùng lặp.",
    ),
    "permissionRequired": MessageLookupByLibrary.simpleMessage(
      "Yêu cầu quyền truy cập",
    ),
    "pixelate": MessageLookupByLibrary.simpleMessage("Dạng Pixel"),
    "pleaseEnterWatermarkText": MessageLookupByLibrary.simpleMessage(
      "Vui lòng nhập văn bản watermark",
    ),
    "pleaseFillAllFields": MessageLookupByLibrary.simpleMessage(
      "Vui lòng điền đầy đủ các trường",
    ),
    "popular": MessageLookupByLibrary.simpleMessage("PHỔ BIẾN NHẤT"),
    "premium": MessageLookupByLibrary.simpleMessage("Premium"),
    "premiumFeatureAiTools": MessageLookupByLibrary.simpleMessage(
      "Mở khóa mọi công cụ AI",
    ),
    "premiumFeatureHighQuality": MessageLookupByLibrary.simpleMessage(
      "Chỉnh sửa ảnh chất lượng cao",
    ),
    "premiumFeatureNoAds": MessageLookupByLibrary.simpleMessage(
      "Không có quảng cáo",
    ),
    "premiumPlan": MessageLookupByLibrary.simpleMessage("Gói Premium"),
    "privacyMatters": MessageLookupByLibrary.simpleMessage(
      "Bảo mật dữ liệu của bạn",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Chính sách bảo mật"),
    "privacySec1Content": MessageLookupByLibrary.simpleMessage(
      "Tại Twinfix, chúng tôi cam kết bảo vệ dữ liệu cá nhân và tôn trọng quyền riêng tư của bạn. Chính sách bảo mật này mô tả chi tiết cách chúng tôi thu thập, lưu trữ, xử lý và bảo mật thông tin khi bạn sử dụng các tính năng làm sạch và tối ưu hóa ảnh.",
    ),
    "privacySec1Title": MessageLookupByLibrary.simpleMessage(
      "1. Cam kết bảo mật",
    ),
    "privacySec2Content": MessageLookupByLibrary.simpleMessage(
      "Chúng tôi xử lý siêu dữ liệu (metadata), thông số ảnh và tệp trực tiếp trên thiết bị của bạn để thực hiện làm mờ khuôn mặt, xóa watermark, phát hiện ảnh trùng lặp và xóa GPS. Việc phân tích cục bộ đảm bảo ảnh của bạn không bao giờ bị tải lên máy chủ ngoài mà không có sự đồng ý của bạn.",
    ),
    "privacySec2Title": MessageLookupByLibrary.simpleMessage(
      "2. Thông tin chúng tôi thu thập",
    ),
    "privacySec3Content": MessageLookupByLibrary.simpleMessage(
      "Tất cả thuật toán quét ảnh trùng lặp và xử lý tệp đều hoạt động trực tiếp trên điện thoại của bạn. Chúng tôi không lưu trữ hoặc gửi nội dung ảnh của bạn đến lưu trữ đám mây bên ngoài. Khi đồng bộ hồ sơ qua Supabase, chỉ các dữ liệu thống kê chung (như chuỗi ngày dọn dẹp, huy hiệu nhận được) mới được truyền tải bảo mật.",
    ),
    "privacySec3Title": MessageLookupByLibrary.simpleMessage(
      "3. Lưu trữ và Truyền tải dữ liệu",
    ),
    "privacySec4Content": MessageLookupByLibrary.simpleMessage(
      "Chúng tôi đặt sự an toàn thông tin của bạn lên hàng đầu. Chúng tôi áp dụng các tiêu chuẩn mã hóa thiết bị mạnh mẽ cùng giao thức kết nối HTTPS/TLS an toàn nhất hiện nay cho việc đồng bộ dữ liệu tài khoản. Không bên thứ ba nào có thể tiếp cận được tệp tin của bạn.",
    ),
    "privacySec4Title": MessageLookupByLibrary.simpleMessage(
      "4. An toàn thông tin",
    ),
    "privacySec5Content": MessageLookupByLibrary.simpleMessage(
      "Nếu bạn có bất kỳ câu hỏi hoặc phản hồi nào về Chính sách bảo mật của Twinfix, xin vui lòng liên hệ với chúng tôi thông qua trang web hỗ trợ chính thức hoặc kênh phản hồi trực tiếp trong ứng dụng.",
    ),
    "privacySec5Title": MessageLookupByLibrary.simpleMessage(
      "5. Liên hệ với chúng tôi",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Cá nhân"),
    "profileUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Cập nhật hồ sơ thành công!",
    ),
    "progress": MessageLookupByLibrary.simpleMessage("Tiến trình"),
    "purchaseErrorStoreConnection": MessageLookupByLibrary.simpleMessage(
      "Không thể kết nối đến cửa hàng.",
    ),
    "purchaseFailureMessage": MessageLookupByLibrary.simpleMessage(
      "Mua hàng thất bại hoặc bị hủy.",
    ),
    "purchaseSuccess": MessageLookupByLibrary.simpleMessage(
      "Nâng cấp Premium thành công!",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Đăng ký"),
    "registerSuccess": MessageLookupByLibrary.simpleMessage(
      "Đăng ký thành công",
    ),
    "registerSuccessMessage": MessageLookupByLibrary.simpleMessage(
      "Vui lòng truy cập vào email và xác thực tài khoản để có thể đăng nhập",
    ),
    "removeGPS": MessageLookupByLibrary.simpleMessage("Xóa GPS"),
    "removeGPSDescription": MessageLookupByLibrary.simpleMessage(
      "Xóa thông tin vị trí khỏi ảnh.",
    ),
    "replaceOriginal": MessageLookupByLibrary.simpleMessage("Thay thế bản gốc"),
    "resetLinkSent": MessageLookupByLibrary.simpleMessage(
      "Liên kết đặt lại mật khẩu đã được gửi đến email của bạn!",
    ),
    "restoreFailureMessage": MessageLookupByLibrary.simpleMessage(
      "Không thể khôi phục giao dịch hoặc bạn chưa đăng ký.",
    ),
    "restoreFromCloud": MessageLookupByLibrary.simpleMessage(
      "Khôi phục từ đám mây",
    ),
    "restorePurchases": MessageLookupByLibrary.simpleMessage(
      "Khôi phục giao dịch (Restore Purchases)",
    ),
    "sat": MessageLookupByLibrary.simpleMessage("Th 7"),
    "save": MessageLookupByLibrary.simpleMessage("Lưu"),
    "saveProfile": MessageLookupByLibrary.simpleMessage("Lưu hồ sơ"),
    "saving": MessageLookupByLibrary.simpleMessage("Đang lưu..."),
    "scanLimit": MessageLookupByLibrary.simpleMessage("Giới hạn quét"),
    "scanLimitAll": MessageLookupByLibrary.simpleMessage("Tất cả"),
    "scanLimitDescription": MessageLookupByLibrary.simpleMessage(
      "Số lượng ảnh tối đa sẽ quét.",
    ),
    "scanLimitWarning": MessageLookupByLibrary.simpleMessage(
      "Giới hạn quét tất cả có thể mất nhiều thời gian và tốn pin hơn.",
    ),
    "scanResults": MessageLookupByLibrary.simpleMessage("Kết quả quét"),
    "scanningDevice": MessageLookupByLibrary.simpleMessage(
      "Đang quét thiết bị...",
    ),
    "scanningDocument": MessageLookupByLibrary.simpleMessage(
      "Đang quét tài liệu...",
    ),
    "screenshots": MessageLookupByLibrary.simpleMessage("Ảnh chụp màn hình"),
    "screenshotsDescription": MessageLookupByLibrary.simpleMessage(
      "Ảnh chụp màn hình là ảnh chụp màn hình. Hãy dọn dẹp chúng để giải phóng dung lượng.",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Tìm kiếm"),
    "security": MessageLookupByLibrary.simpleMessage("Bảo mật"),
    "selectAll": MessageLookupByLibrary.simpleMessage("Chọn tất cả"),
    "selectAvatar": MessageLookupByLibrary.simpleMessage("Chọn ảnh đại diện"),
    "selectEmoji": MessageLookupByLibrary.simpleMessage("Chọn Emoji"),
    "selectFrame": MessageLookupByLibrary.simpleMessage("Chọn khung"),
    "selectTemplate": MessageLookupByLibrary.simpleMessage("Chọn mẫu"),
    "sendFeedbackSubtitle": MessageLookupByLibrary.simpleMessage(
      "Chúng tôi luôn lắng nghe ý kiến của bạn!",
    ),
    "sendFeedbackTitle": MessageLookupByLibrary.simpleMessage(
      "Gửi phản hồi của bạn",
    ),
    "sendResetLink": MessageLookupByLibrary.simpleMessage(
      "Gửi liên kết đặt lại",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Cài đặt"),
    "sevenDays": MessageLookupByLibrary.simpleMessage("7 Ngày"),
    "sevenWeeks": MessageLookupByLibrary.simpleMessage("7 Tuần"),
    "signInWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Đăng nhập bằng Google",
    ),
    "size": MessageLookupByLibrary.simpleMessage("Kích thước"),
    "sizeAsc": MessageLookupByLibrary.simpleMessage("Kích thước tăng dần"),
    "sizeDesc": MessageLookupByLibrary.simpleMessage("Kích thước giảm dần"),
    "skip": MessageLookupByLibrary.simpleMessage("Bỏ qua"),
    "solid": MessageLookupByLibrary.simpleMessage("Màu đặc"),
    "sort": MessageLookupByLibrary.simpleMessage("Sắp xếp"),
    "startFresh": MessageLookupByLibrary.simpleMessage("Bắt đầu mới"),
    "startQuickScan": MessageLookupByLibrary.simpleMessage(
      "Bắt đầu quét nhanh",
    ),
    "startQuickScanDescription": MessageLookupByLibrary.simpleMessage(
      "Nút này dùng để quét thư viện và tìm ảnh trùng chỉ với vài thao tác.",
    ),
    "stats": MessageLookupByLibrary.simpleMessage("Thống kê"),
    "storageAlmostFull": m15,
    "streak": MessageLookupByLibrary.simpleMessage("Chuỗi ngày"),
    "streakDays": m16,
    "streaks": MessageLookupByLibrary.simpleMessage("Chuỗi ngày"),
    "submitFeedback": MessageLookupByLibrary.simpleMessage("Gửi phản hồi"),
    "success": MessageLookupByLibrary.simpleMessage("Thành công"),
    "sun": MessageLookupByLibrary.simpleMessage("CN"),
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
    "tapToChangeStyle": MessageLookupByLibrary.simpleMessage(
      "Chạm để thay đổi phong cách",
    ),
    "template_copyright": MessageLookupByLibrary.simpleMessage("Bản quyền"),
    "template_glass": MessageLookupByLibrary.simpleMessage("Trong suốt"),
    "template_minimal": MessageLookupByLibrary.simpleMessage("Tối giản"),
    "template_outline": MessageLookupByLibrary.simpleMessage("Viền"),
    "template_standard": MessageLookupByLibrary.simpleMessage("Tiêu chuẩn"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Điều khoản và Điều kiện",
    ),
    "termsOfService": MessageLookupByLibrary.simpleMessage(
      "Điều khoản dịch vụ",
    ),
    "termsSec1Content": MessageLookupByLibrary.simpleMessage(
      "Bằng việc truy cập hoặc sử dụng ứng dụng Twinfix, bạn đồng ý tuân thủ và chịu ràng buộc bởi các Điều khoản dịch vụ này. Nếu bạn không đồng ý với bất kỳ phần nào của điều khoản, vui lòng dừng sử dụng ứng dụng ngay lập tức.",
    ),
    "termsSec1Title": MessageLookupByLibrary.simpleMessage(
      "1. Chấp nhận các Điều khoản",
    ),
    "termsSec2Content": MessageLookupByLibrary.simpleMessage(
      "Twinfix cung cấp các tính năng tối ưu hóa bộ nhớ thiết bị, bao gồm phát hiện ảnh trùng lặp trên thiết bị, loại bỏ siêu dữ liệu định vị, làm mờ khuôn mặt/watermark và thống kê dọn dẹp bộ nhớ. Chúng tôi cung cấp dịch vụ này ở trạng thái \"nguyên bản\" và có quyền thay đổi hoặc ngưng cung cấp các tính năng bất kỳ lúc nào.",
    ),
    "termsSec2Title": MessageLookupByLibrary.simpleMessage("2. Mô tả Dịch vụ"),
    "termsSec3Content": MessageLookupByLibrary.simpleMessage(
      "Một số dịch vụ cao cấp của Twinfix yêu cầu đăng ký thuê bao hoặc mua trực tiếp trong ứng dụng. Bạn chịu trách nhiệm bảo mật thông tin đăng nhập và phương thức thanh toán của mình. Các giao dịch này được xử lý bảo mật bởi hệ thống chính thức của cửa hàng ứng dụng (App Store / Google Play).",
    ),
    "termsSec3Title": MessageLookupByLibrary.simpleMessage(
      "3. Tài khoản và Đăng ký gói",
    ),
    "termsSec4Content": MessageLookupByLibrary.simpleMessage(
      "Bạn đồng ý sử dụng Twinfix chỉ cho các mục đích hợp pháp. Bạn không được cố gắng giải mã ngược ứng dụng (reverse-engineer), khai thác lỗ hổng bảo mật, hack hoặc can thiệp vào các hoạt động bình thường của ứng dụng hoặc hệ thống đồng bộ dữ liệu.",
    ),
    "termsSec4Title": MessageLookupByLibrary.simpleMessage(
      "4. Quy định sử dụng hợp lệ",
    ),
    "termsSec5Content": MessageLookupByLibrary.simpleMessage(
      "Twinfix thực hiện các lệnh xóa ảnh dựa trên sự xác nhận trực tiếp của bạn. Chúng tôi không chịu trách nhiệm đối với bất kỳ mất mát tệp ảnh ngoài ý muốn nào, hư hỏng dữ liệu hoặc lỗi thiết bị do dung lượng lưu trữ đầy. Vui lòng kiểm tra kỹ lưỡng các ảnh được chọn để xóa.",
    ),
    "termsSec5Title": MessageLookupByLibrary.simpleMessage(
      "5. Giới hạn Trách nhiệm",
    ),
    "text": MessageLookupByLibrary.simpleMessage("Văn bản"),
    "theme": MessageLookupByLibrary.simpleMessage("Giao diện"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Tối"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Sáng"),
    "themeSystem": MessageLookupByLibrary.simpleMessage("Hệ thống"),
    "thu": MessageLookupByLibrary.simpleMessage("Th 5"),
    "totalPhotos": m17,
    "totalPhotosLast7Days": m18,
    "totalPhotosLast7Weeks": m19,
    "tue": MessageLookupByLibrary.simpleMessage("Th 3"),
    "tune": MessageLookupByLibrary.simpleMessage("Điều chỉnh"),
    "unknown": MessageLookupByLibrary.simpleMessage("Không xác định"),
    "unknownUser": MessageLookupByLibrary.simpleMessage("Người dùng ẩn danh"),
    "upgradeToPremium": MessageLookupByLibrary.simpleMessage(
      "Nâng cấp Premium",
    ),
    "vietnamese": MessageLookupByLibrary.simpleMessage("Tiếng Việt"),
    "viewAllBadges": MessageLookupByLibrary.simpleMessage(
      "Xem tất cả huy hiệu",
    ),
    "viewDetail": MessageLookupByLibrary.simpleMessage("Xem chi tiết"),
    "viewFullHistory": MessageLookupByLibrary.simpleMessage(
      "Xem toàn bộ lịch sử",
    ),
    "watermarkText": MessageLookupByLibrary.simpleMessage("Văn bản Watermark"),
    "website": MessageLookupByLibrary.simpleMessage("Trang web"),
    "wed": MessageLookupByLibrary.simpleMessage("Th 4"),
    "weekShort": MessageLookupByLibrary.simpleMessage("T."),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Chào mừng trở lại"),
  };
}

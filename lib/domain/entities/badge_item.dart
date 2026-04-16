class BadgeItem {
  final String id;
  final String name;
  final String description;
  final String iconUrl; // Or local asset path

  const BadgeItem({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
  });
}

// Sample Badges
class AppBadges {
  // ===== BASIC =====
  static const BadgeItem newbie = BadgeItem(
    id: 'newbie',
    name: 'Người mới dọn dẹp',
    description: 'Bắt đầu cuộc hành trình giải cứu bộ nhớ thiết bị.',
    iconUrl: 'assets/badges/newbie.png',
  );

  static const BadgeItem firstClean = BadgeItem(
    id: 'first_clean',
    name: 'Phát dọn lần đầu',
    description: 'Xóa những bức ảnh đầu tiên.',
    iconUrl: 'assets/badges/first_clean.png',
  );

  // ===== DELETE COUNT =====
  static const BadgeItem cleaner10 = BadgeItem(
    id: 'cleaner_10',
    name: 'Tập sự dọn dẹp',
    description: 'Xóa 10 ảnh.',
    iconUrl: 'assets/badges/cleaner_10.png',
  );

  static const BadgeItem cleaner100 = BadgeItem(
    id: 'cleaner_100',
    name: 'Chuyên gia dọn dẹp',
    description: 'Xóa 100 ảnh.',
    iconUrl: 'assets/badges/cleaner_100.png',
  );

  static const BadgeItem cleaner1000 = BadgeItem(
    id: 'cleaner_1000',
    name: 'Máy nghiền ảnh',
    description: 'Xóa 1000 ảnh.',
    iconUrl: 'assets/badges/cleaner_1000.png',
  );

  // ===== BLURRY =====
  static const BadgeItem blurryHunter = BadgeItem(
    id: 'blurry_10',
    name: 'Thợ săn ảnh mờ',
    description: 'Xóa 10 ảnh mờ.',
    iconUrl: 'assets/badges/blurry_10.png',
  );

  static const BadgeItem blurryKiller = BadgeItem(
    id: 'blurry_killer',
    name: 'Sát thủ ảnh mờ',
    description: 'Xóa 50 ảnh mờ đầu tiên.',
    iconUrl: 'assets/badges/blurry_killer.png',
  );

  static const BadgeItem blurryDestroyer = BadgeItem(
    id: 'blurry_200',
    name: 'Kẻ hủy diệt ảnh mờ',
    description: 'Xóa 200 ảnh mờ.',
    iconUrl: 'assets/badges/blurry_200.png',
  );

  // ===== DUPLICATE =====
  static const BadgeItem duplicateFinder = BadgeItem(
    id: 'duplicate_20',
    name: 'Thợ săn ảnh trùng',
    description: 'Xóa 20 ảnh trùng.',
    iconUrl: 'assets/badges/duplicate_20.png',
  );

  static const BadgeItem duplicateMaster = BadgeItem(
    id: 'duplicate_100',
    name: 'Bậc thầy ảnh trùng',
    description: 'Xóa 100 ảnh trùng.',
    iconUrl: 'assets/badges/duplicate_100.png',
  );

  // ===== STORAGE =====
  static const BadgeItem freed100mb = BadgeItem(
    id: 'freed_100mb',
    name: 'Giải phóng nhẹ',
    description: 'Giải phóng 100MB dữ liệu.',
    iconUrl: 'assets/badges/freed_100mb.png',
  );

  static const BadgeItem gigabyteKing = BadgeItem(
    id: 'giga_king',
    name: 'Vua bộ nhớ',
    description: 'Giải phóng hơn 1GB dữ liệu.',
    iconUrl: 'assets/badges/giga_king.png',
  );

  static const BadgeItem freed5gb = BadgeItem(
    id: 'freed_5gb',
    name: 'Thợ săn dung lượng',
    description: 'Giải phóng 5GB dữ liệu.',
    iconUrl: 'assets/badges/freed_5gb.png',
  );

  static const BadgeItem freed10gb = BadgeItem(
    id: 'freed_10gb',
    name: 'Kẻ huỷ diệt ổ cứng',
    description: 'Giải phóng 10GB dữ liệu.',
    iconUrl: 'assets/badges/freed_10gb.png',
  );

  // ===== STREAK =====
  static const BadgeItem streak3 = BadgeItem(
    id: 'streak_3',
    name: 'Chăm chỉ',
    description: 'Dọn dẹp 3 ngày liên tiếp.',
    iconUrl: 'assets/badges/streak_3.png',
  );

  static const BadgeItem streak7 = BadgeItem(
    id: 'streak_7',
    name: 'Không bỏ cuộc',
    description: 'Dọn dẹp 7 ngày liên tiếp.',
    iconUrl: 'assets/badges/streak_7.png',
  );

  // ===== SPECIAL =====
  static const BadgeItem speedCleaner = BadgeItem(
    id: 'speed_clean',
    name: 'Dọn dẹp thần tốc',
    description: 'Xóa 50 ảnh trong một lần.',
    iconUrl: 'assets/badges/speed_clean.png',
  );

  static const BadgeItem aiUser = BadgeItem(
    id: 'ai_cleaner',
    name: 'Trợ thủ AI',
    description: 'Sử dụng tính năng dọn dẹp tự động.',
    iconUrl: 'assets/badges/ai_cleaner.png',
  );

  static const BadgeItem perfectionist = BadgeItem(
    id: 'perfectionist',
    name: 'Người cầu toàn',
    description: 'Xóa hơn 80% ảnh mờ trong thiết bị.',
    iconUrl: 'assets/badges/perfectionist.png',
  );

  // ===== ALL =====
  static const List<BadgeItem> allBadges = [
    newbie,
    firstClean,

    cleaner10,
    cleaner100,
    cleaner1000,

    blurryHunter,
    blurryKiller,
    blurryDestroyer,

    duplicateFinder,
    duplicateMaster,

    freed100mb,
    gigabyteKing,
    freed5gb,
    freed10gb,

    streak3,
    streak7,

    speedCleaner,
    aiUser,
    perfectionist,
  ];
}

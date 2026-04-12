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
  static const BadgeItem newbie = BadgeItem(
    id: 'newbie',
    name: 'Người mới dọn dẹp',
    description: 'Bắt đầu cuộc hành trình giải cứu bộ nhớ thiết bị.',
    iconUrl: 'assets/badges/newbie.png',
  );

  static const BadgeItem blurryKiller = BadgeItem(
    id: 'blurry_killer',
    name: 'Sát thủ ảnh mờ',
    description: 'Xóa 50 ảnh mờ đầu tiên.',
    iconUrl: 'assets/badges/blurry_killer.png',
  );

  static const BadgeItem gigabyteKing = BadgeItem(
    id: 'giga_king',
    name: 'Vua bộ nhớ',
    description: 'Giải phóng hơn 1GB dữ liệu.',
    iconUrl: 'assets/badges/giga_king.png',
  );

  static const List<BadgeItem> allBadges = [newbie, blurryKiller, gigabyteKing];
}

import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final isVi = locale == 'vi';

    // Premium styling and harmonized content
    final sections = isVi ? _getVietnameseSections() : _getEnglishSections();

    return AppScaffold(
      title: l10n.privacyPolicy,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 75 + 12,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).padding.bottom + 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Intro Card with premium gradient borders/shadows
            AppTransparentContainer(
              padding: 20.paddingAll,
              child: Row(
                children: [
                  Container(
                    padding: 12.paddingAll,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.privacy_tip_rounded,
                      color: theme.colorScheme.primary,
                      size: 32,
                    ),
                  ),
                  16.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isVi
                              ? 'Bảo mật dữ liệu của bạn'
                              : 'Your Privacy Matters',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        4.height,
                        Text(
                          isVi
                              ? 'Cập nhật lần cuối: 27 tháng 5, 2026'
                              : 'Last updated: May 27, 2026',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            20.height,

            // Policy Sections
            ...sections.map((section) => _buildSection(context, section)),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, _PolicySection section) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AppTransparentContainer(
        padding: 16.paddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  section.icon,
                  color: theme.colorScheme.primary.withValues(alpha: 0.9),
                  size: 20,
                ),
                10.width,
                Expanded(
                  child: Text(
                    section.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            12.height,
            Text(
              section.content,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.5,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<_PolicySection> _getEnglishSections() {
    return [
      _PolicySection(
        icon: Icons.shield_outlined,
        title: '1. Commitment to Privacy',
        content:
            'At Twinfix, we are dedicated to protecting your personal data and respect your privacy. This Privacy Policy details how we collect, store, process, and protect your information when you utilize our image cleaning and optimization services.',
      ),
      _PolicySection(
        icon: Icons.camera_enhance_outlined,
        title: '2. Information We Collect',
        content:
            'We process image metadata, photo metrics, and files directly on your local device to perform face blurring, watermark removal, duplicate detection, and metadata deletion. Local analysis ensures your original photos are never uploaded to any remote servers without your explicit consent.',
      ),
      _PolicySection(
        icon: Icons.storage_outlined,
        title: '3. Data Storage & Transfer',
        content:
            'All optimization tools, duplicate scanning algorithms, and processing layers run natively on your smartphone. We do not store or transmit any image content to external cloud storage. When user profiles sync with Supabase, only metadata (like streak count, cleaning badges, and general stats) is synchronized securely.',
      ),
      _PolicySection(
        icon: Icons.lock_outline_rounded,
        title: '4. Information Security',
        content:
            'We prioritize the safety of your information. We apply robust device-level cryptographic practices and industry-leading transport security protocol (HTTPS/TLS) for account interactions and statistics sync. No third parties can access your processed files.',
      ),
      _PolicySection(
        icon: Icons.contact_support_outlined,
        title: '5. Contact Us',
        content:
            'If you have any questions or feedback regarding this Privacy Policy or data handling practices in Twinfix, please contact us through the official support website or in-app feedback channel.',
      ),
    ];
  }

  List<_PolicySection> _getVietnameseSections() {
    return [
      _PolicySection(
        icon: Icons.shield_outlined,
        title: '1. Cam kết bảo mật',
        content:
            'Tại Twinfix, chúng tôi cam kết bảo vệ dữ liệu cá nhân và tôn trọng quyền riêng tư của bạn. Chính sách bảo mật này mô tả chi tiết cách chúng tôi thu thập, lưu trữ, xử lý và bảo mật thông tin khi bạn sử dụng các tính năng làm sạch và tối ưu hóa ảnh.',
      ),
      _PolicySection(
        icon: Icons.camera_enhance_outlined,
        title: '2. Thông tin chúng tôi thu thập',
        content:
            'Chúng tôi xử lý siêu dữ liệu (metadata), thông số ảnh và tệp trực tiếp trên thiết bị của bạn để thực hiện làm mờ khuôn mặt, xóa watermark, phát hiện ảnh trùng lặp và xóa GPS. Việc phân tích cục bộ đảm bảo ảnh của bạn không bao giờ bị tải lên máy chủ ngoài mà không có sự đồng ý của bạn.',
      ),
      _PolicySection(
        icon: Icons.storage_outlined,
        title: '3. Lưu trữ và Truyền tải dữ liệu',
        content:
            'Tất cả thuật toán quét ảnh trùng lặp và xử lý tệp đều hoạt động trực tiếp trên điện thoại của bạn. Chúng tôi không lưu trữ hoặc gửi nội dung ảnh của bạn đến lưu trữ đám mây bên ngoài. Khi đồng bộ hồ sơ qua Supabase, chỉ các dữ liệu thống kê chung (như chuỗi ngày dọn dẹp, huy hiệu nhận được) mới được truyền tải bảo mật.',
      ),
      _PolicySection(
        icon: Icons.lock_outline_rounded,
        title: '4. An toàn thông tin',
        content:
            'Chúng tôi đặt sự an toàn thông tin của bạn lên hàng đầu. Chúng tôi áp dụng các tiêu chuẩn mã hóa thiết bị mạnh mẽ cùng giao thức kết nối HTTPS/TLS an toàn nhất hiện nay cho việc đồng bộ dữ liệu tài khoản. Không bên thứ ba nào có thể tiếp cận được tệp tin của bạn.',
      ),
      _PolicySection(
        icon: Icons.contact_support_outlined,
        title: '5. Liên hệ với chúng tôi',
        content:
            'Nếu bạn có bất kỳ câu hỏi hoặc phản hồi nào về Chính sách bảo mật của Twinfix, xin vui lòng liên hệ với chúng tôi thông qua trang web hỗ trợ chính thức hoặc kênh phản hồi trực tiếp trong ứng dụng.',
      ),
    ];
  }
}

class _PolicySection {
  final IconData icon;
  final String title;
  final String content;

  _PolicySection({
    required this.icon,
    required this.title,
    required this.content,
  });
}

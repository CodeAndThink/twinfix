import 'package:flutter/material.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final isVi = locale == 'vi';

    // Premium styling and harmonized content
    final sections = isVi ? _getVietnameseSections() : _getEnglishSections();

    return AppScaffold(
      title: l10n.termsOfService,
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
            // Intro Card with premium style
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
                      Icons.description_rounded,
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
                              ? 'Điều khoản và Điều kiện'
                              : 'Terms & Conditions',
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

            // Terms Sections
            ...sections.map((section) => _buildSection(context, section)),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, _TermsSection section) {
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

  List<_TermsSection> _getEnglishSections() {
    return [
      _TermsSection(
        icon: Icons.gavel_outlined,
        title: '1. Acceptance of Terms',
        content:
            'By accessing or using Twinfix, you agree to comply with and be bound by these Terms of Service. If you do not agree with any part of these terms, you should immediately cease using the application.',
      ),
      _TermsSection(
        icon: Icons.cleaning_services_outlined,
        title: '2. Description of Service',
        content:
            'Twinfix offers device storage optimization features, including local duplicate image detection, metadata removal, face/watermark blurring, and performance statistics tracking. We provide these services "as-is" and reserve the right to modify or discontinue features at any time.',
      ),
      _TermsSection(
        icon: Icons.person_outline_rounded,
        title: '3. User Accounts & Subscriptions',
        content:
            'Certain premium services in Twinfix require active subscriptions or in-app purchases. You are responsible for safeguarding your credentials and payment methods. Subscription processing is securely handled by official store systems (Apple App Store / Google Play).',
      ),
      _TermsSection(
        icon: Icons.policy_outlined,
        title: '4. Permissible Usage',
        content:
            'You agree to use Twinfix only for lawful purposes. You must not attempt to reverse-engineer, exploit, hack, or disrupt the operation of the application, local database architectures, or backend synchronization systems.',
      ),
      _TermsSection(
        icon: Icons.warning_amber_rounded,
        title: '5. Limitation of Liability',
        content:
            'Twinfix runs photo deletion and cleanup commands directly under user direction. We are not liable for any accidental loss of image files, data corruption, or hardware errors resulting from your configuration or device storage constraints. Please verify any photo deletion selection carefully.',
      ),
    ];
  }

  List<_TermsSection> _getVietnameseSections() {
    return [
      _TermsSection(
        icon: Icons.gavel_outlined,
        title: '1. Chấp nhận các Điều khoản',
        content:
            'Bằng việc truy cập hoặc sử dụng ứng dụng Twinfix, bạn đồng ý tuân thủ và chịu ràng buộc bởi các Điều khoản dịch vụ này. Nếu bạn không đồng ý với bất kỳ phần nào của điều khoản, vui lòng dừng sử dụng ứng dụng ngay lập tức.',
      ),
      _TermsSection(
        icon: Icons.cleaning_services_outlined,
        title: '2. Mô tả Dịch vụ',
        content:
            'Twinfix cung cấp các tính năng tối ưu hóa bộ nhớ thiết bị, bao gồm phát hiện ảnh trùng lặp trên thiết bị, loại bỏ siêu dữ liệu định vị, làm mờ khuôn mặt/watermark và thống kê dọn dẹp bộ nhớ. Chúng tôi cung cấp dịch vụ này ở trạng thái "nguyên bản" và có quyền thay đổi hoặc ngưng cung cấp các tính năng bất kỳ lúc nào.',
      ),
      _TermsSection(
        icon: Icons.person_outline_rounded,
        title: '3. Tài khoản và Đăng ký gói',
        content:
            'Một số dịch vụ cao cấp của Twinfix yêu cầu đăng ký thuê bao hoặc mua trực tiếp trong ứng dụng. Bạn chịu trách nhiệm bảo mật thông tin đăng nhập và phương thức thanh toán của mình. Các giao dịch này được xử lý bảo mật bởi hệ thống chính thức của cửa hàng ứng dụng (App Store / Google Play).',
      ),
      _TermsSection(
        icon: Icons.policy_outlined,
        title: '4. Quy định sử dụng hợp lệ',
        content:
            'Bạn đồng ý sử dụng Twinfix chỉ cho các mục đích hợp pháp. Bạn không được cố gắng giải mã ngược ứng dụng (reverse-engineer), khai thác lỗ hổng bảo mật, hack hoặc can thiệp vào các hoạt động bình thường của ứng dụng hoặc hệ thống đồng bộ dữ liệu.',
      ),
      _TermsSection(
        icon: Icons.warning_amber_rounded,
        title: '5. Giới hạn Trách nhiệm',
        content:
            'Twinfix thực hiện các lệnh xóa ảnh dựa trên sự xác nhận trực tiếp của bạn. Chúng tôi không chịu trách nhiệm đối với bất kỳ mất mát tệp ảnh ngoài ý muốn nào, hư hỏng dữ liệu hoặc lỗi thiết bị do dung lượng lưu trữ đầy. Vui lòng kiểm tra kỹ lưỡng các ảnh được chọn để xóa.',
      ),
    ];
  }
}

class _TermsSection {
  final IconData icon;
  final String title;
  final String content;

  _TermsSection({
    required this.icon,
    required this.title,
    required this.content,
  });
}

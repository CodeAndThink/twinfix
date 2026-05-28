import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import '../cubit/privacy_cubit.dart';
import '../navigator/privacy_navigator.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrivacyCubit(navigator: PrivacyNavigator(context)),
      child: const PrivacyChildPage(),
    );
  }
}

class PrivacyChildPage extends StatelessWidget {
  const PrivacyChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    final sections = [
      _PolicySection(
        icon: Icons.shield_outlined,
        title: l10n.privacySec1Title,
        content: l10n.privacySec1Content,
      ),
      _PolicySection(
        icon: Icons.camera_enhance_outlined,
        title: l10n.privacySec2Title,
        content: l10n.privacySec2Content,
      ),
      _PolicySection(
        icon: Icons.storage_outlined,
        title: l10n.privacySec3Title,
        content: l10n.privacySec3Content,
      ),
      _PolicySection(
        icon: Icons.lock_outline_rounded,
        title: l10n.privacySec4Title,
        content: l10n.privacySec4Content,
      ),
      _PolicySection(
        icon: Icons.contact_support_outlined,
        title: l10n.privacySec5Title,
        content: l10n.privacySec5Content,
      ),
    ];

    return AppScaffold(
      title: l10n.privacyPolicy,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 75 + 12,
          left: 12,
          right: 12,
          bottom: MediaQuery.of(context).padding.bottom + 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTransparentContainer(
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
                  12.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.privacyMatters,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        4.height,
                        Text(
                          l10n.lastUpdatedDate('27/05/2026'),
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
            12.height,
            ...sections.map((section) => _buildSection(context, section)),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, _PolicySection section) {
    final theme = Theme.of(context);

    return Padding(
      padding: 12.paddingBottom,
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

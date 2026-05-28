import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import '../cubit/terms_of_service_cubit.dart';
import '../navigator/terms_of_service_navigator.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TermsOfServiceCubit(navigator: TermsOfServiceNavigator(context)),
      child: const TermsOfServiceChildPage(),
    );
  }
}

class TermsOfServiceChildPage extends StatelessWidget {
  const TermsOfServiceChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    final sections = [
      _TermsSection(
        icon: Icons.gavel_outlined,
        title: l10n.termsSec1Title,
        content: l10n.termsSec1Content,
      ),
      _TermsSection(
        icon: Icons.cleaning_services_outlined,
        title: l10n.termsSec2Title,
        content: l10n.termsSec2Content,
      ),
      _TermsSection(
        icon: Icons.person_outline_rounded,
        title: l10n.termsSec3Title,
        content: l10n.termsSec3Content,
      ),
      _TermsSection(
        icon: Icons.policy_outlined,
        title: l10n.termsSec4Title,
        content: l10n.termsSec4Content,
      ),
      _TermsSection(
        icon: Icons.warning_amber_rounded,
        title: l10n.termsSec5Title,
        content: l10n.termsSec5Content,
      ),
    ];

    return AppScaffold(
      title: l10n.termsOfService,
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
                      Icons.description_rounded,
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
                          l10n.termsAndConditions,
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

  Widget _buildSection(BuildContext context, _TermsSection section) {
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

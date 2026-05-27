import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/configs/app_configs.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/titles/app_title_header.dart';
import '../cubit/about_cubit.dart';
import '../navigator/about_navigator.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AboutCubit(navigator: AboutNavigator(context)),
      child: const AboutChildPage(),
    );
  }
}

class AboutChildPage extends StatefulWidget {
  const AboutChildPage({super.key});

  @override
  State<AboutChildPage> createState() => _AboutChildPageState();
}

class _AboutChildPageState extends State<AboutChildPage> {
  late final AboutCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<AboutCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return AppScaffold(
      title: l10n.aboutUs,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 75 + 12,
          left: 12,
          right: 12,
          bottom: MediaQuery.of(context).padding.bottom + 12,
        ),
        child: Column(
          children: [
            // App Icon and Name
            Center(
              child: Column(
                children: [
                  Hero(
                    tag: 'app_icon',
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: 24.borderRadius,
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: 24.borderRadius,
                        child: AppAssetImage(path: AppAssets.icon),
                      ),
                    ),
                  ),
                  12.height,
                  Text(
                    l10n.appName,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  4.height,
                  Text(
                    l10n.appVersion(AppConfigs.version),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.secondary.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            20.height,

            // Description
            AppTransparentContainer(
              padding: 20.paddingAll,
              child: Text(
                l10n.aboutDescription,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
              ),
            ),
            20.height,

            // Features Title
            AppTitleHeader(title: l10n.featuresTitle),

            // Features List
            _buildFeatureTile(
              context,
              icon: Icons.flash_on_rounded,
              title: l10n.featureScan,
              color: Colors.amber,
            ),
            12.height,
            _buildFeatureTile(
              context,
              icon: Icons.cleaning_services_rounded,
              title: l10n.featureClean,
              color: Colors.blue,
            ),
            12.height,
            _buildFeatureTile(
              context,
              icon: Icons.palette_rounded,
              title: l10n.featureModernUI,
              color: Colors.green,
            ),

            // Footer Links
            AppTitleHeader(title: l10n.footerTitle),
            AppTransparentContainer(
              padding: 10.paddingAll,
              child: Column(
                children: [
                  _buildFooterLink(
                    context,
                    title: l10n.email,
                    icon: Icons.mail_outline_rounded,
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _buildFooterLink(
                    context,
                    title: l10n.privacyPolicy,
                    icon: Icons.privacy_tip_outlined,
                    onTap: () => _cubit.navigator.goToPrivacy(),
                  ),
                  const Divider(height: 1),
                  _buildFooterLink(
                    context,
                    title: l10n.termsOfService,
                    icon: Icons.description_outlined,
                    onTap: () => _cubit.navigator.goToTermsOfService(),
                  ),
                ],
              ),
            ),
            30.height,

            // Mascot Image
            AppAssetImage(path: AppAssets.icCrocodile0, height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return AppTransparentContainer(
      padding: 12.paddingAll,
      child: Row(
        children: [
          Container(
            padding: 8.paddingAll,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          16.width,
          Expanded(child: Text(title, style: theme.textTheme.titleSmall)),
        ],
      ),
    );
  }

  Widget _buildFooterLink(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.secondary, size: 20),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 14,
        color: theme.colorScheme.secondary.withValues(alpha: 0.5),
      ),
      onTap: onTap,
    );
  }
}

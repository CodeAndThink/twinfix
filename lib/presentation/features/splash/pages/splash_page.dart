import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/constants/app_assets.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/splash/cubit/splash_cubit.dart';
import 'package:twinfix/presentation/features/splash/cubit/splash_state.dart';
import 'package:twinfix/presentation/features/splash/navigator/splash_navigator.dart';
import 'package:twinfix/presentation/widgets/images/app_asset_image.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(
        navigator: SplashNavigator(context),
        permissionService: locator(),
      ),
      child: const SplashChildPage(),
    );
  }
}

class SplashChildPage extends StatefulWidget {
  const SplashChildPage({super.key});

  @override
  State<SplashChildPage> createState() => _SplashChildPageState();
}

class _SplashChildPageState extends State<SplashChildPage> {
  late final SplashCubit _cubit;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SplashCubit>();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _l10n = S.of(context);

    return BlocBuilder<SplashCubit, SplashState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: _theme.colorScheme.surface,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Branding Mascot
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: _theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: AppAssetImage(path: AppAssets.icon),
                ),
                24.height,
                Text(
                  _l10n.appName,
                  style: _theme.textTheme.headlineMedium?.copyWith(
                    color: _theme.colorScheme.primary,
                    letterSpacing: 2,
                  ),
                ),
                8.height,
                Text(
                  _l10n.appDescription,
                  style: _theme.textTheme.bodyMedium?.copyWith(
                    color: _theme.colorScheme.secondary,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

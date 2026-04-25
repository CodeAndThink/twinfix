import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/app/cubit/theme_state.dart';
import 'core/navigation/app_router.dart';
import 'presentation/app/cubit/app_cubit.dart';
import 'presentation/app/cubit/theme_cubit.dart';

import 'presentation/app/cubit/locale_cubit.dart';
import 'presentation/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load variables from .env
  await dotenv.load(fileName: ".env");

  // Khởi tạo Supabase Client
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  await configureDependencies();
  runApp(const TwinfixApp());
}

class TwinfixApp extends StatelessWidget {
  const TwinfixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator<AppCubit>()),
        BlocProvider(create: (context) => locator<ThemeCubit>()),
        BlocProvider(create: (context) => locator<LocaleCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        buildWhen: (previous, current) =>
            previous.themeMode != current.themeMode,
        builder: (context, themeState) {
          return BlocBuilder<LocaleCubit, LocaleState>(
            buildWhen: (previous, current) => previous.locale != current.locale,
            builder: (context, localeState) {
              return MaterialApp.router(
                routerConfig: AppRouter.router,
                onGenerateTitle: (context) => S.of(context).appName,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: localeState.locale,
                themeMode: themeState.themeMode,
                theme: AppTheme.light(),
                darkTheme: AppTheme.dark(),
                builder: (context, child) {
                  return ResponsiveBreakpoints.builder(
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaler: const TextScaler.linear(1.0),
                        boldText: false,
                      ),
                      child: child!,
                    ),
                    breakpoints: [
                      const Breakpoint(start: 0, end: 450, name: MOBILE),
                      const Breakpoint(start: 451, end: 800, name: TABLET),
                      const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/presentation/app/cubit/theme_cubit.dart';
import 'package:twinfix/presentation/app/cubit/theme_state.dart';
import 'package:twinfix/presentation/widgets/scaffold/custom_app_bar.dart';
import '../loadings/app_loading_overlay.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final PreferredSizeWidget? appBar;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final bool showAppBar;
  final bool isShowBackground;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? bottom;
  final Widget? leading;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final bool extendBody;
  final bool isLoading;
  final String? loadingMessage;

  const AppScaffold({
    super.key,
    this.title,
    required this.body,
    this.appBar,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.showAppBar = true,
    this.isShowBackground = true,
    this.floatingActionButton,
    this.bottom,
    this.leading,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
    this.extendBody = false,
    this.isLoading = false,
    this.loadingMessage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        final backgroundPath = isDarkMode
            ? state.backgroundType.darkBackgroundPath
            : state.backgroundType.lightBackgroundPath;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: showAppBar
              ? appBar ??
                    (title != null
                        ? CustomAppBar(
                            title: title!,
                            leading: leading,
                            actions: actions,
                            automaticallyImplyLeading:
                                automaticallyImplyLeading,
                            bottom: bottom,
                          )
                        : null)
              : null,
          body: Stack(
            children: [
              if (isShowBackground && backgroundPath != null)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(backgroundPath),
                        repeat: ImageRepeat.noRepeat,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
              Positioned.fill(child: body),
              if (isLoading) const Positioned.fill(child: AppLoadingOverlay()),
            ],
          ),
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          extendBody: extendBody,
        );
      },
    );
  }
}

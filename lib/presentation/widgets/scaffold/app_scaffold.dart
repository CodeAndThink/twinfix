import 'package:flutter/material.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_custom_app_bar.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final bool isBack;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool isShowAppBar;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.isBack = true,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.isShowAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
      appBar: isShowAppBar
          ? appBar ?? AppCustomAppBar(title: title, isBack: isBack)
          : null,
      body: SafeArea(child: body),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

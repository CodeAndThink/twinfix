import 'package:flutter/material.dart';

class AppCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBack;
  final Widget? leading;
  final List<Widget>? actions;

  const AppCustomAppBar({
    super.key,
    required this.title,
    this.isBack = true,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Text(title, style: theme.textTheme.titleMedium),
      centerTitle: true,
      elevation: 0,
      leading: leading ?? (isBack ? const BackButton() : null),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

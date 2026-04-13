import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/constants/app_colors.dart';

import 'package:go_router/go_router.dart';
import '../../../widgets/scaffold/app_scaffold.dart';

class MainPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isShowAppBar: false,
      title: '',
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: _onTap,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.placeholderText,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.cleaning_services),
              label: S.of(context).tabScan,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.emoji_events),
              label: S.of(context).tabDashboard,
            ),
          ],
        ),
      ),
    );
  }
}

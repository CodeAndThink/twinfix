import 'package:flutter/material.dart';
import 'package:twinfix/presentation/features/main/widgets/custom_bottom_navigation_bar.dart';

import 'package:go_router/go_router.dart';

class MainPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          if (index != navigationShell.currentIndex) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          }
        },
      ),
    );
  }
}

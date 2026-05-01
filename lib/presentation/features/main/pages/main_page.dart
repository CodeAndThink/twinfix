import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:twinfix/core/services/global_services.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/presentation/features/main/navigator/main_navigator.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class MainPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (state.isSyncAllow && state.authStatus.isSuccess) {
          MainNavigator(context).dialog.showUserSyncDialog(
            onMerge: () => context.read<AppCubit>().syncLocalData(true),
            onDiscard: () => context.read<AppCubit>().syncLocalData(false),
          );
        }
      },
      child: Scaffold(
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
            if (index == 2) {
              GlobalServices.instance.updateAchievement();
            } else if (index == 3) {
              GlobalServices.instance.updateSetting();
            }
          },
        ),
      ),
    );
  }
}

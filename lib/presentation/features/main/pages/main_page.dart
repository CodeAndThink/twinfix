import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:twinfix/presentation/app/cubit/app_cubit.dart';
import 'package:twinfix/presentation/widgets/dialogs/user_sync_dialog.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class MainPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (state is NeedSync) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => UserSyncDialog(
              onMerge: () => context.read<AppCubit>().finalizeSync(true),
              onDiscard: () => context.read<AppCubit>().finalizeSync(false),
            ),
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
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/profile_detail/cubit/profile_detail_state.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/enums/load_status.dart';
import '../cubit/profile_detail_cubit.dart';
import '../navigator/profile_detail_navigator.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileDetailCubit(navigator: ProfileDetailNavigator(context)),
      child: const _ProfileDetailView(),
    );
  }
}

class _ProfileDetailView extends StatefulWidget {
  const _ProfileDetailView();

  @override
  State<_ProfileDetailView> createState() => _ProfileDetailViewState();
}

class _ProfileDetailViewState extends State<_ProfileDetailView> {
  late final ProfileDetailCubit _cubit;
  late S _l10n;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProfileDetailCubit>();
    _cubit.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);

    return AppScaffold(
      title: _l10n.profile,
      body: SafeArea(
        child: BlocBuilder<ProfileDetailCubit, ProfileDetailState>(
          buildWhen: (previous, current) =>
              previous.loadStatus != current.loadStatus,
          builder: (context, state) {
            if (state.loadStatus == LoadStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: 16.padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  32.height,
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: state.avatarUrl.isNotEmpty
                          ? NetworkImage(state.avatarUrl)
                          : null,
                      child: state.avatarUrl.isEmpty
                          ? const Icon(Icons.person, size: 50)
                          : null,
                    ),
                  ),
                  16.height,
                  Text(
                    state.name.isNotEmpty ? state.name : _l10n.unknownUser,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  8.height,
                  Text(
                    state.email.isNotEmpty
                        ? state.email
                        : _l10n.noEmailProvided,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  32.height,
                  const Spacer(),
                  AppFilledButton(
                    onPressed: () => _cubit.logout(),
                    text: _l10n.logout,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

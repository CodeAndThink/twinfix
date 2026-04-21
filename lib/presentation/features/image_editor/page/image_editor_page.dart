import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/domain/repositories/photo_repository.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/image_editor/cubit/image_editor_cubit.dart';
import 'package:twinfix/presentation/features/image_editor/widgets/custom_pro_image_editor.dart';
import 'package:twinfix/presentation/features/image_editor/cubit/image_editor_state.dart';
import 'package:twinfix/presentation/features/image_editor/navigator/image_editor_navigator.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';

class ImageEditorPage extends StatelessWidget {
  const ImageEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageEditorCubit(
        navigator: ImageEditorNavigator(context),
        photoRepository: locator<PhotoRepository>(),
      ),
      child: ImageEditorChildPage(),
    );
  }
}

class ImageEditorChildPage extends StatefulWidget {
  const ImageEditorChildPage({super.key});

  @override
  State<ImageEditorChildPage> createState() => _ImageEditorPageState();
}

class _ImageEditorPageState extends State<ImageEditorChildPage> {
  late final ImageEditorCubit _cubit;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ImageEditorCubit>();
    _cubit.pickImage();
  }

  void _showSuccessDialog() {
    _cubit.navigator.showImageEditorSuccessDialog(
      onFinish: () => _cubit.navigator.safePop(),
      onEditAnother: () => _cubit.pickImage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return BlocConsumer<ImageEditorCubit, ImageEditorState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          _showSuccessDialog();
        } else if (state.status.isFailure) {
          _cubit.navigator.dialog.showError(
            title: _l10n.unknown,
            message: state.errorMessage ?? "",
          );
        }
      },
      buildWhen: (p, c) => p.selectedImage != c.selectedImage,
      builder: (context, state) {
        if (state.selectedImage == null) {
          return AppScaffold(
            title: _l10n.edit,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_search_rounded,
                    size: 80,
                    color: _theme.colorScheme.primary.withValues(alpha: 0.5),
                  ),
                  24.height,
                  Text(
                    _l10n
                        .confirmnoMorePhotosToDelete, // Reusing a string or using a generic one
                    style: _theme.textTheme.bodyLarge,
                  ),
                  24.height,
                  AppFilledButton(
                    text: _l10n.edit,
                    onPressed: () => _cubit.pickImage(),
                  ),
                ],
              ),
            ),
          );
        }

        return Stack(
          children: [
            CustomProImageEditor(
              imagePath: state.selectedImage!.path,
              onSaveComplete: (bytes) {
                _cubit.save(bytes: bytes);
              },
              onClose: () {},
              onSaveStarted: () {},
            ),
            if (state.status.isLoading)
              Container(
                color: _theme.colorScheme.primary.withValues(alpha: 0.5),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      16.height,
                      Text(
                        _l10n.saving,
                        style: _theme.textTheme.bodyMedium?.copyWith(
                          color: _theme.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

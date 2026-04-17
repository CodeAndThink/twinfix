import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/watermark/cubit/watermark_cubit.dart';
import 'package:twinfix/presentation/features/watermark/cubit/watermark_state.dart';
import 'package:twinfix/presentation/features/watermark/widgets/watermark_bottom_bar.dart';
import 'package:twinfix/presentation/features/watermark/widgets/watermark_image_preview.dart';
import 'package:twinfix/presentation/features/watermark/widgets/watermark_sliders.dart';
import 'package:twinfix/presentation/features/watermark/widgets/watermark_template_selector.dart';
import 'package:twinfix/presentation/features/watermark/widgets/watermark_text_input.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:image_picker/image_picker.dart';

class WatermarkPageArgs {
  final XFile image;

  const WatermarkPageArgs({required this.image});
}

class WatermarkPage extends StatelessWidget {
  final WatermarkPageArgs args;
  const WatermarkPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WatermarkCubit(photoRepository: locator()),
      child: WatermarkChildPage(args: args),
    );
  }
}

class WatermarkChildPage extends StatefulWidget {
  final WatermarkPageArgs args;
  const WatermarkChildPage({super.key, required this.args});

  @override
  State<WatermarkChildPage> createState() => _WatermarkChildPageState();
}

class _WatermarkChildPageState extends State<WatermarkChildPage> {
  late final WatermarkCubit _cubit;
  late final TextEditingController _textController;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<WatermarkCubit>();
    _textController = TextEditingController();
    _textController.addListener(() {
      _cubit.onTextChanged(_textController.text);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.onImagePathChanged(widget.args.image.path);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return BlocConsumer<WatermarkCubit, WatermarkState>(
      listenWhen: (previous, current) =>
          previous.isSaved != current.isSaved ||
          previous.status != current.status ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.isSaved) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(_l10n.imageSaved)));
          Navigator.pop(context);
        }
        if (state.errorMessage != null && state.status.isFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return AppScaffold(
          extendBody: true,
          title: _l10n.addWaterMark,
          isLoading: state.status.isLoading,
          loadingMessage: _l10n.saving,
          backgroundColor: Colors.transparent,
          body: _buildBody(state),
          bottomNavigationBar: WatermarkBottomBar(
            state: state,
            cubit: _cubit,
            onSavePressed: _showSaveOptions,
          ),
        );
      },
    );
  }

  Widget _buildBody(WatermarkState state) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: MediaQuery.of(context).padding.top + 75 + 12,
        bottom: MediaQuery.of(context).padding.bottom + 72 + 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WatermarkImagePreview(state: state),
          24.height,
          Text(
            _l10n.watermarkText,
            style: _theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          8.height,
          WatermarkTextInput(controller: _textController),
          24.height,
          WatermarkSliders(state: state, cubit: _cubit),
          24.height,
          Text(
            _l10n.selectTemplate,
            style: _theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          12.height,
          WatermarkTemplateSelector(state: state, cubit: _cubit),
        ],
      ),
    );
  }

  void _showSaveOptions() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.copy_rounded,
                  color: _theme.colorScheme.primary,
                ),
                title: Text(_l10n.createNewImage),
                onTap: () {
                  Navigator.pop(context);
                  _cubit.save(isReplace: false);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.published_with_changes_rounded,
                  color: Colors.orange,
                ),
                title: Text(_l10n.replaceOriginal),
                onTap: () {
                  Navigator.pop(context);
                  _cubit.save(isReplace: true);
                },
              ),
              16.height,
            ],
          ),
        );
      },
    );
  }
}

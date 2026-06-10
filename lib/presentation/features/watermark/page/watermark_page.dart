import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/watermark/cubit/watermark_cubit.dart';
import 'package:twinfix/presentation/features/watermark/cubit/watermark_state.dart';
import 'package:twinfix/presentation/features/watermark/widgets/watermark_bottom_bar.dart';
import 'package:twinfix/presentation/features/watermark/widgets/watermark_image_preview.dart';
import 'package:twinfix/presentation/features/watermark/widgets/watermark_sliders.dart';
import 'package:twinfix/presentation/features/watermark/widgets/watermark_template_selector.dart';
import 'package:twinfix/presentation/features/watermark/widgets/watermark_color_selector.dart';
import 'package:twinfix/presentation/features/watermark/widgets/watermark_text_input.dart';
import 'package:twinfix/presentation/features/watermark/navigator/watermark_navigator.dart';
import 'package:twinfix/core/utils/app_utils.dart';
import 'package:twinfix/presentation/widgets/loadings/app_loading_overlay.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twinfix/presentation/widgets/text/app_title_text.dart';

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
      create: (context) => WatermarkCubit(
        photoRepository: locator(),
        navigator: WatermarkNavigator(context),
      ),
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
        if (state.status.isLoading) {
          AppLoadingOverlay.show(context);
        } else {
          AppLoadingOverlay.hide();
        }
        if (state.isSaved && state.processedImageBytes != null) {
          _cubit.navigator.dialog.showImageProcessedSuccessDialog(
            imageBytes: state.processedImageBytes!,
            onShare: () {
              AppUtils.shareImage(state.processedImageBytes!);
            },
            onDone: () {
              _cubit.navigator.safePop();
            },
          );
        }
        if (state.errorMessage != null && state.status.isFailure) {
          _cubit.navigator.flushBar.showError(
            message: state.errorMessage ?? _l10n.defaultErrorMessage,
          );
        }
      },
      builder: (context, state) {
        return AppScaffold(
          extendBody: true,
          title: _l10n.addWaterMark,
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
          AppTitleText(title: _l10n.watermarkText),
          WatermarkTextInput(controller: _textController),
          WatermarkSliders(
            state: state,
            cubit: _cubit,
            enabled: state.text.isNotEmpty,
          ),
          WatermarkColorSelector(
            state: state,
            cubit: _cubit,
            enabled: state.text.isNotEmpty,
          ),
          AppTitleText(
            title: _l10n.selectTemplate,
            style: _theme.textTheme.titleMedium?.copyWith(
              color: state.text.isNotEmpty ? null : _theme.disabledColor,
            ),
          ),
          WatermarkTemplateSelector(
            state: state,
            cubit: _cubit,
            enabled: state.text.isNotEmpty,
          ),
        ],
      ),
    );
  }

  void _showSaveOptions() async {
    _cubit.save();
  }
}

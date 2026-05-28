import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/domain/enums/feedback_type.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/containers/app_transparent_container.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:twinfix/presentation/widgets/text_fields/app_text_field.dart';
import 'package:twinfix/presentation/widgets/titles/app_title_header.dart';
import '../cubit/contact_cubit.dart';
import '../cubit/contact_state.dart';
import '../navigator/contact_navigator.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactCubit(navigator: ContactNavigator(context)),
      child: const ContactChildPage(),
    );
  }
}

class ContactChildPage extends StatefulWidget {
  const ContactChildPage({super.key});

  @override
  State<ContactChildPage> createState() => _ContactChildPageState();
}

class _ContactChildPageState extends State<ContactChildPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _titleFocusNode = FocusNode();
  final _contentFocusNode = FocusNode();
  FeedbackType _selectedType = FeedbackType.bug;
  late final ContactCubit _cubit;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ContactCubit>();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _titleFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  void _submitForm() {
    _unfocus();
    if (!_formKey.currentState!.validate()) return;

    final l10n = S.of(context);

    _cubit.submitFeedback(
      type: _selectedType,
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      successMsg: l10n.openingEmailApp,
      errorMsgTemplate: l10n.couldNotOpenEmailApp('{email}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _l10n = S.of(context);

    return AppScaffold(title: _l10n.contactUs, body: _buildBody());
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 75 + 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUnfocus,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Contact Header Banner Card
            Padding(
              padding: 12.paddingHorizontal,
              child: AppTransparentContainer(
                padding: 16.paddingAll,
                child: Row(
                  children: [
                    Container(
                      padding: 12.paddingAll,
                      decoration: BoxDecoration(
                        color: _theme.colorScheme.primary.withValues(
                          alpha: 0.1,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.mark_as_unread_rounded,
                        color: _theme.colorScheme.primary,
                        size: 28,
                      ),
                    ),
                    16.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _l10n.sendFeedbackTitle,
                            style: _theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          4.height,
                          Text(
                            _l10n.sendFeedbackSubtitle,
                            style: _theme.textTheme.bodySmall?.copyWith(
                              color: _theme.colorScheme.onSurfaceVariant
                                  .withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            12.height,
            AppTransparentContainer(
              padding: 12.paddingAll,
              child: Column(
                children: [
                  // 1. Feedback Type Title
                  AppTitleHeader(title: _l10n.feedbackTypeLabel),

                  // Feedback Type Buttons (Choice grid)
                  _buildFeedbackTypeGrid(),

                  // 2. Feedback Title Text Field
                  AppTitleHeader(title: _l10n.feedbackTitleLabel),
                  AppTextField(
                    controller: _titleController,
                    focusNode: _titleFocusNode,
                    hintText: _l10n.feedbackTitleHint,
                    prefixIcon: Icons.title_rounded,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return _l10n.feedbackTitleRequired;
                      }
                      return null;
                    },
                  ),

                  // 3. Feedback Content Text Field
                  AppTitleHeader(title: _l10n.feedbackContentLabel),
                  AppTextField(
                    controller: _contentController,
                    focusNode: _contentFocusNode,
                    hintText: _l10n.feedbackContentHint,
                    maxLines: 6,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return _l10n.feedbackContentRequired;
                      }
                      return null;
                    },
                  ),
                  20.height,

                  // 4. Submit Button
                  BlocBuilder<ContactCubit, ContactState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      return AppFilledButton(
                        text: _l10n.submitFeedback,
                        icon: Icons.send_rounded,
                        isLoading: state.status.isLoading,
                        onPressed: _submitForm,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackTypeGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: EdgeInsets.zero,
      children: FeedbackType.values.map((type) {
        final isSelected = _selectedType == type;
        final String label = type.label;
        final IconData icon = type.icon;
        final Color activeColor = type.color;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedType = type;
            });
          },
          child: AnimatedContainer(
            duration: 250.milliseconds,
            padding: 12.paddingHorizontal,
            decoration: BoxDecoration(
              borderRadius: 16.borderRadius,
              border: Border.all(
                color: isSelected
                    ? activeColor
                    : _theme.colorScheme.outlineVariant,
                width: isSelected ? 2 : 1,
              ),
              color: isSelected
                  ? activeColor
                  : _theme.colorScheme.surfaceContainerLow.withValues(
                      alpha: 0.6,
                    ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? _theme.colorScheme.surface
                      : _theme.colorScheme.secondary,
                  size: 24,
                ),
                10.width,
                Expanded(
                  child: Text(
                    label,
                    style: _theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: isSelected ? FontWeight.bold : null,
                      color: isSelected
                          ? _theme.colorScheme.surface
                          : _theme.colorScheme.secondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

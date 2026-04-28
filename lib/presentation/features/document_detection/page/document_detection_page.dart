import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twinfix/core/di/injection.dart';
import 'package:twinfix/core/extensions/extensions.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/presentation/features/confirm_delete/page/confirm_delete_page.dart';
import 'package:twinfix/presentation/features/document_detection/widgets/document_detection_list_item.dart';
import 'package:twinfix/presentation/widgets/buttons/app_filled_button.dart';
import 'package:twinfix/presentation/widgets/scaffold/app_scaffold.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../cubit/document_detection_cubit.dart';
import '../cubit/document_detection_state.dart';
import 'document_detection_loading_page.dart';
import '../navigator/document_detection_navigator.dart';

class DocumentDetectionPage extends StatelessWidget {
  const DocumentDetectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DocumentDetectionCubit(
        locator(),
        DocumentDetectionNavigator(context),
      ),
      child: const DocumentDetectionChildPage(),
    );
  }
}

class DocumentDetectionChildPage extends StatefulWidget {
  const DocumentDetectionChildPage({super.key});

  @override
  State<DocumentDetectionChildPage> createState() =>
      _DocumentDetectionChildPageState();
}

class _DocumentDetectionChildPageState
    extends State<DocumentDetectionChildPage> {
  late final DocumentDetectionCubit _cubit;
  late S _l10n;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<DocumentDetectionCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(400.milliseconds);
      if (mounted) {
        _cubit.startScan();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _l10n = S.of(context);
    _theme = Theme.of(context);

    return AppScaffold(title: _l10n.document, body: _buildBody());
  }

  Widget _buildBody() {
    return SafeArea(
      child: BlocBuilder<DocumentDetectionCubit, DocumentDetectionState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status.isLoading || state.status.isInitial) {
            return const DocumentDetectionLoadingPage();
          }
          if (state.status.isSuccess) {
            if (state.documents.isEmpty) {
              return _buildEmptyUI();
            }
            return _buildResultUI();
          }
          return Center(child: Text(state.errorMessage ?? _l10n.unknown));
        },
      ),
    );
  }

  Widget _buildEmptyUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: 64,
            color: _theme.colorScheme.primary.withValues(alpha: 0.5),
          ),
          16.height,
          Text(_l10n.noDocumentsFound, style: _theme.textTheme.titleMedium),
          32.height,
          AppFilledButton(
            text: _l10n.back,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultUI() {
    return BlocBuilder<DocumentDetectionCubit, DocumentDetectionState>(
      buildWhen: (previous, current) =>
          previous.selectedIds != current.selectedIds,
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: 12.paddingAll,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveValue<int>(
                    context,
                    conditionalValues: [
                      const Condition.equals(name: MOBILE, value: 3),
                      const Condition.largerThan(name: MOBILE, value: 5),
                    ],
                    defaultValue: 3,
                  ).value,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.documents.length,
                itemBuilder: (context, index) {
                  final document = state.documents[index];
                  final isSelected = state.selectedIds.contains(document.id);
                  final isSelectionMode = state.selectedIds.isNotEmpty;

                  return DocumentDetectionListItem(
                    photo: document,
                    isSelected: isSelected,
                    onTap: () {
                      if (isSelectionMode) {
                        _cubit.toggleSelection(id: document.id);
                      } else {
                        _cubit.navigator.navigateToMediaViewer(document);
                      }
                    },
                    onLongPress: () {
                      if (!isSelectionMode) {
                        _cubit.toggleSelection(id: document.id);
                      }
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: 12.paddingHorizontal,
              child: SizedBox(
                width: double.maxFinite,
                child: AppFilledButton(
                  backgroundColor: Colors.red,
                  text: _l10n.deleteSelected(state.selectedIds.length),
                  onPressed: state.selectedIds.isNotEmpty
                      ? () async {
                          final itemsToDelete = state.documents
                              .where((e) => state.selectedIds.contains(e.id))
                              .toList();

                          final result = await _cubit.navigator
                              .openConfirmDelete(itemsToDelete);

                          if (result is ConfirmDeleteResult) {
                            await _cubit.deleteDocuments(
                              ids: result.deletedIds,
                            );
                            _cubit.clearSelection();
                          }
                        }
                      : null,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:twinfix/core/enums/load_status.dart';
import 'package:twinfix/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:twinfix/presentation/widgets/cubit/base_cubit.dart';
import 'contact_state.dart';
import '../navigator/contact_navigator.dart';
import 'package:twinfix/domain/enums/feedback_type.dart';

class ContactCubit extends BaseCubit<ContactState> {
  final ContactNavigator navigator;

  ContactCubit({required this.navigator}) : super(ContactState.initial());

  Future<void> submitFeedback({
    required FeedbackType type,
    required String title,
    required String content,
    required String successMsg,
    required String errorMsgTemplate,
  }) async {
    if (state.status.isLoading) return;
    safeEmit(state.copyWith(status: LoadStatus.loading));

    // Retrieve email from .env
    final email = dotenv.env['EMAIL_CONTACT'];
    if (email == null) {
      navigator.flushBar.showError(message: S.current.errorEmailNotFound);
      safeEmit(state.copyWith(status: LoadStatus.failure));
      return;
    }

    final String typeLabel = type.emailSubjectLabel;
    final subject = '[Twinfix Feedback - $typeLabel] $title';

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: _encodeQueryParameters(<String, String>{
        'subject': subject,
        'body': content,
      }),
    );

    try {
      final launched = await launchUrl(
        emailLaunchUri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        throw Exception('Could not launch');
      }
    } catch (e) {
      final formattedError = errorMsgTemplate.replaceAll('{email}', email);
      navigator.flushBar.showError(message: formattedError);
    } finally {
      safeEmit(state.copyWith(status: LoadStatus.success));
    }
  }

  String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }
}

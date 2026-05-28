import 'package:flutter/material.dart';
import 'package:twinfix/generated/l10n.dart';

enum FeedbackType {
  bug,
  improvement,
  question,
  other;

  IconData get icon {
    switch (this) {
      case FeedbackType.bug:
        return Icons.bug_report_rounded;
      case FeedbackType.improvement:
        return Icons.insights_rounded;
      case FeedbackType.question:
        return Icons.help_outline_rounded;
      case FeedbackType.other:
        return Icons.more_horiz_rounded;
    }
  }

  Color get color {
    switch (this) {
      case FeedbackType.bug:
        return Colors.red;
      case FeedbackType.improvement:
        return Colors.blue;
      case FeedbackType.question:
        return Colors.green;
      case FeedbackType.other:
        return Colors.purple;
    }
  }

  String get label {
    switch (this) {
      case FeedbackType.bug:
        return S.current.feedbackTypeBug;
      case FeedbackType.improvement:
        return S.current.feedbackTypeImprovement;
      case FeedbackType.question:
        return S.current.feedbackTypeQuestion;
      case FeedbackType.other:
        return S.current.feedbackTypeOther;
    }
  }

  String get emailSubjectLabel {
    switch (this) {
      case FeedbackType.bug:
        return 'Bug';
      case FeedbackType.improvement:
        return 'Improvement';
      case FeedbackType.question:
        return 'Question';
      case FeedbackType.other:
        return 'Other';
    }
  }
}

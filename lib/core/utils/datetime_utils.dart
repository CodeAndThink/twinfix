import 'package:intl/intl.dart';
import 'package:twinfix/presentation/features/media_timeline/cubit/media_timeline_state.dart';

class DatetimeUtils {
  static DateTime fromMillisecondsSinceEpoch({
    required int millisecondsSinceEpoch,
  }) {
    return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  }

  static String formatTimelineDate(
    DateTime date,
    TimelineMode mode, [
    String? locale,
  ]) {
    switch (mode) {
      case TimelineMode.day:
        return formatTimelineDay(date, locale);
      case TimelineMode.month:
        return formatTimelineMonth(date, locale);
      case TimelineMode.year:
        return formatTimelineYear(date, locale);
    }
  }

  static String formatTimelineDay(DateTime date, [String? locale]) {
    return DateFormat.yMd(locale).format(date);
  }

  static String formatTimelineMonth(DateTime date, [String? locale]) {
    return DateFormat.yMMMM(locale).format(date);
  }

  static String formatTimelineYear(DateTime date, [String? locale]) {
    return DateFormat.y(locale).format(date);
  }
}

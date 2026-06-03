import 'package:intl/intl.dart';
import 'package:twinfix/presentation/features/media_timeline/cubit/media_timeline_state.dart';

class DatetimeUtils {
  static DateTime fromMillisecondsSinceEpoch({
    required int millisecondsSinceEpoch,
  }) {
    return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  }

  static String formatTimelineDate(DateTime date, TimelineMode mode) {
    switch (mode) {
      case TimelineMode.day:
        return DateFormat('yyyy-MM-dd').format(date);
      case TimelineMode.month:
        return DateFormat('yyyy-MM').format(date);
      case TimelineMode.year:
        return DateFormat('yyyy').format(date);
    }
  }
}

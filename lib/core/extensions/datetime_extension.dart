import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  String get dayOfWeek => DateFormat('E').format(this);

  String get dayMonthYear => DateFormat('dd/MM/yyyy').format(this);

  String get dayMonth => DateFormat('dd/MM').format(this);

  String get monthYear => DateFormat('MMMM yyyy').format(this);

  String get dayMonthYearWithHyphen => DateFormat('dd-MM-yyyy').format(this);

  String get yearDashMonthDashDay => DateFormat('yyyy-MM-dd').format(this);

  String get dayMonthYearWithDot => DateFormat('dd.MM.yyyy').format(this);

  String get dayMonthYearWithSpace => DateFormat('dd MMMM yyyy').format(this);

  String get dayMonthYearWithSlash => DateFormat('dd/MM/yyyy').format(this);

  String get dayMonthYearWithSlashAndSpace =>
      DateFormat('dd/MM/yyyy').format(this);

  String get dayMonthYearWithSlashAndSpaceAndDot =>
      DateFormat('dd/MM/yyyy').format(this);

  String get dayMonthYearWithSlashAndSpaceAndDotAndHyphen =>
      DateFormat('dd/MM/yyyy').format(this);

  String get hourMinuteSpaceDayMonthYear =>
      DateFormat('HH:mm dd/MM/yyyy').format(this);
}

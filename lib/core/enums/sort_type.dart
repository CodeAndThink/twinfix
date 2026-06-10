import 'package:flutter/material.dart';
import 'package:twinfix/generated/l10n.dart';

enum SortType {
  dateDesc,
  dateAsc,
  sizeDesc,
  sizeAsc,
  countDesc,
  countAsc;

  bool get isDateDesc => this == dateDesc;

  bool get isDateAsc => this == dateAsc;

  bool get isSizeDesc => this == sizeDesc;

  bool get isSizeAsc => this == sizeAsc;

  bool get isCountDesc => this == countDesc;

  bool get isCountAsc => this == countAsc;
}

extension SortTypeExtension on SortType {
  IconData get icon {
    switch (this) {
      case SortType.dateDesc:
        return Icons.schedule;
      case SortType.dateAsc:
        return Icons.schedule;
      case SortType.sizeDesc:
        return Icons.aspect_ratio;
      case SortType.sizeAsc:
        return Icons.aspect_ratio;
      case SortType.countDesc:
        return Icons.format_list_numbered_rounded;
      case SortType.countAsc:
        return Icons.format_list_numbered_rounded;
    }
  }

  IconData get secondIcon {
    switch (this) {
      case SortType.dateDesc:
        return Icons.expand_more;
      case SortType.dateAsc:
        return Icons.expand_less;
      case SortType.sizeDesc:
        return Icons.expand_more;
      case SortType.sizeAsc:
        return Icons.expand_less;
      case SortType.countDesc:
        return Icons.expand_more;
      case SortType.countAsc:
        return Icons.expand_less;
    }
  }

  String get label {
    switch (this) {
      case SortType.dateDesc:
        return S.current.dateDesc;
      case SortType.dateAsc:
        return S.current.dateAsc;
      case SortType.sizeDesc:
        return S.current.sizeDesc;
      case SortType.sizeAsc:
        return S.current.sizeAsc;
      case SortType.countDesc:
        return S.current.countDesc;
      case SortType.countAsc:
        return S.current.countAsc;
    }
  }
}

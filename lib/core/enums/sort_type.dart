import 'package:flutter/material.dart';
import 'package:twinfix/generated/l10n.dart';

enum SortType {
  dateDesc,
  dateAsc,
  sizeDesc,
  sizeAsc;

  bool get isDateDesc => this == dateDesc;

  bool get isDateAsc => this == dateAsc;

  bool get isSizeDesc => this == sizeDesc;

  bool get isSizeAsc => this == sizeAsc;
}

extension SortTypeExtension on SortType {
  IconData get icon {
    switch (this) {
      case SortType.dateDesc:
        return Icons.date_range_rounded;
      case SortType.dateAsc:
        return Icons.date_range_rounded;
      case SortType.sizeDesc:
        return Icons.straighten;
      case SortType.sizeAsc:
        return Icons.straighten;
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
    }
  }
}

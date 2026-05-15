import 'package:flutter/material.dart';

enum AvatarFrameType {
  none,
  gold,
  silver,
  blue,
  purple,
  red;

  int get id => index;

  String get name {
    switch (this) {
      case AvatarFrameType.none:
        return 'None';
      case AvatarFrameType.gold:
        return 'Gold';
      case AvatarFrameType.silver:
        return 'Silver';
      case AvatarFrameType.blue:
        return 'Blue';
      case AvatarFrameType.purple:
        return 'Purple';
      case AvatarFrameType.red:
        return 'Red';
    }
  }

  Color get color {
    switch (this) {
      case AvatarFrameType.none:
        return Colors.transparent;
      case AvatarFrameType.gold:
        return Colors.amber;
      case AvatarFrameType.silver:
        return Colors.grey;
      case AvatarFrameType.blue:
        return Colors.blue;
      case AvatarFrameType.purple:
        return Colors.purple;
      case AvatarFrameType.red:
        return Colors.red;
    }
  }

  static AvatarFrameType fromId(int id) {
    if (id < 0 || id >= AvatarFrameType.values.length) {
      return AvatarFrameType.none;
    }
    return AvatarFrameType.values[id];
  }
}

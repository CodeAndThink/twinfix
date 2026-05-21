enum AvatarType {
  crocodile0,
  crocodile1,
  crocodile2,
  crocodile3,
  crocodile4;

  int get id => index;

  String get path {
    switch (this) {
      case AvatarType.crocodile0:
        return 'assets/images/mascot/ic_crocodile_0.png';
      case AvatarType.crocodile1:
        return 'assets/images/mascot/ic_crocodile_1.png';
      case AvatarType.crocodile2:
        return 'assets/images/mascot/ic_crocodile_2.png';
      case AvatarType.crocodile3:
        return 'assets/images/mascot/ic_crocodile_3.png';
      case AvatarType.crocodile4:
        return 'assets/images/mascot/ic_crocodile_4.png';
    }
  }

  static AvatarType fromId(int id) {
    if (id < 0 || id >= AvatarType.values.length) {
      return AvatarType.crocodile0;
    }
    return AvatarType.values[id];
  }
}

enum ScanMode {
  quick,
  deep;

  bool get isQuick => this == ScanMode.quick;
  bool get isDeep => this == ScanMode.deep;
}

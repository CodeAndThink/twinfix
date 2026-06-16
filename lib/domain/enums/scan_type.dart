/// Identifies the type of scan operation for foreground service notifications.
enum ScanType {
  duplicates,
  blurry,
  documents,
  gps,
  cancelled;

  /// String value used for native MethodChannel communication.
  String get value => name;
}

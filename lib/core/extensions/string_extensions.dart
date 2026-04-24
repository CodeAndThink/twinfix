extension StringExtensions on String {
  /// Check if string is a valid email
  bool get isValidEmail => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(this);

  /// Capitalize first letter
  String get capitalize =>
      isEmpty ? this : "${this[0].toUpperCase()}${substring(1)}";

  /// Convert to double
  double get toDouble => double.tryParse(this) ?? 0.0;

  /// Convert to int
  int get toInt => int.tryParse(this) ?? 0;
}

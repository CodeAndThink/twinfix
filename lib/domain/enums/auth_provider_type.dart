enum AuthProviderType {
  email('email'),
  google('google'),
  apple('apple'),
  unknown('unknown');

  final String value;
  const AuthProviderType(this.value);

  static AuthProviderType fromString(String value) {
    return AuthProviderType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuthProviderType.unknown,
    );
  }
}

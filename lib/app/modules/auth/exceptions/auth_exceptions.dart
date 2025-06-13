class AuthCredentialsException implements Exception {
  final String message;
  final String? code; // Código do erro original (Firebase)
  AuthCredentialsException(this.message, {this.code});
  @override
  String toString() => message;
}

class AuthGenericException implements Exception {
  final String message;
  AuthGenericException(this.message);
  @override
  String toString() => message;
}

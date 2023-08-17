sealed class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class AuthError extends AuthException {
  AuthError(super.message);
}

class AuthUnauthorizedException extends AuthException {
  AuthUnauthorizedException() : super('');
}
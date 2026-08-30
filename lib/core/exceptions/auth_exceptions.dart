class AuthException implements Exception {
  final String message;

  const AuthException(this.message);

  @override
  String toString() => message;
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException() : super('Invalid email or password.');
}

class EmailAlreadyInUseException extends AuthException {
  const EmailAlreadyInUseException() : super('This email is already in use.');
}

class WeakPasswordException extends AuthException {
  const WeakPasswordException() : super('The password is too weak.');
}

class InvalidEmailException extends AuthException {
  const InvalidEmailException() : super('The email address is invalid.');
}

class UserNotFoundException extends AuthException {
  const UserNotFoundException() : super('User not found.');
}

class UserDisabledException extends AuthException {
  const UserDisabledException() : super('This account has been disabled.');
}

class TooManyRequestsException extends AuthException {
  const TooManyRequestsException() : super('Too many requests. Please try again later.');
}

class AuthUnknownException extends AuthException {
  const AuthUnknownException() : super('Something went wrong. Please try again.');
}

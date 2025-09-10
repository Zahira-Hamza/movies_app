abstract class AuthException {
  final String message;
  const AuthException(this.message);
}

class ApiException extends AuthException{
  const ApiException(super.message);
}

class SharedPrefException extends AuthException{
  const SharedPrefException(super.message);
}

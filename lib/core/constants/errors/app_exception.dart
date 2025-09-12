abstract class AppException {
  final String message;
  const AppException(this.message);
}

class ApiException extends AppException {
  const ApiException(super.message);
}

class SharedPrefException extends AppException {
  const SharedPrefException(super.message);
}

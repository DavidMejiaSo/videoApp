class WrongCredentials implements Exception {}

class ConnectionTimeOut implements Exception {}

class CustomError implements Exception {
  final String message;
  // final int errorCode;
  CustomError(this.message);
}

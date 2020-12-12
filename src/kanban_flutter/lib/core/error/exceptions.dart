import 'failures.dart';

class ServerException extends Failure implements Exception {
  final String message;

  ServerException(this.message);
}

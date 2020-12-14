abstract class Failure {
  String get message;
  Exception get exception;
}

class GenericFailure extends Failure {
  final String _message;

  @override
  final Exception exception;

  @override
  String get message => _message ?? exception?.toString();

  GenericFailure({String message, this.exception}) : _message = message;
}

import 'package:flutter/foundation.dart';

abstract class Failure {
  String get message;
  Exception get exception;
}

class GenericFailure extends Failure {
  @override
  final String message;

  @override
  final Exception exception;

  GenericFailure({@required this.message, this.exception})
      : assert(message?.isNotEmpty == true);
}

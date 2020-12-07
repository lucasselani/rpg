import 'package:rpg/base/functional/failure.dart';

abstract class ViewState {
  bool get isBusy => this is BusyState;

  bool get isError => this is ErrorState;

  bool get isIdle => this is IdleState;

  Failure get error {
    if (isError) {
      return (this as ErrorState)._value;
    } else {
      throw Exception('Illegal use. You should isError check before calling ');
    }
  }
}

class BusyState extends ViewState {}

class ErrorState extends ViewState {
  final Failure _value;

  ErrorState({Failure failure}) : _value = failure;
}

class IdleState extends ViewState {}

import 'package:flutter_test/flutter_test.dart';
import 'package:rpg/base/functional/failure.dart';
import 'package:rpg/base/view/view_state.dart';

void main() {
  test('should throw exception when state is idle and tries to get failure',
      () {
    expect(() => IdleState().error, throwsException);
  });

  test('should throw exception when state is busy and tries to get failure',
      () {
    expect(() => BusyState().error, throwsException);
  });

  test('should return null when state is error and has no failure object', () {
    expect(ErrorState().error, null);
  });

  test('should return failure when state is error and has a failure object',
      () {
    final state = ErrorState(failure: GenericFailure(message: 'error'));
    expect(state.error is GenericFailure, true);
    expect(state.error?.message, 'error');
  });
}

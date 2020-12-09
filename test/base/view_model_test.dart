import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:rpg/base/view/view_model.dart';
import 'package:rpg/base/view/view_state.dart';

class _MockViewModel extends ViewModel {}

void main() {
  test('should start in idle state', () {
    final viewModel = _MockViewModel();
    expect(viewModel.state.isIdle, true);
  });

  test('should change to busy state', () {
    final viewModel = _MockViewModel();
    viewModel.state = BusyState();
    expect(viewModel.state.isIdle, false);
    expect(viewModel.state.isBusy, true);
  });

  test('should change to error state', () {
    final viewModel = _MockViewModel();
    viewModel.state = ErrorState();
    expect(viewModel.state.isIdle, false);
    expect(viewModel.state.isError, true);
  });

  test('should change states back and forth', () {
    final viewModel = _MockViewModel();
    viewModel.state = ErrorState();
    expect(viewModel.state.isIdle, false);
    expect(viewModel.state.isError, true);
    viewModel.state = BusyState();
    expect(viewModel.state.isError, false);
    expect(viewModel.state.isBusy, true);
    viewModel.state = IdleState();
    expect(viewModel.state.isBusy, false);
    expect(viewModel.state.isIdle, true);
  });

  test('should find view model in Get DI', () {
    final viewModel = _MockViewModel();
    Get.put(viewModel);
    expect(ViewModel.find<_MockViewModel>() != null, true);
  });
}

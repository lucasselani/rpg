import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:rpg/base/functional/failure.dart';
import 'package:rpg/base/view/view.dart';
import 'package:rpg/base/view/view_model.dart';
import 'package:rpg/base/view/view_state.dart';

import '../utils/widget_test_utils.dart';

class _MockViewModel extends ViewModel {}

class _MockView extends View<_MockViewModel> {
  _MockView() : super(_MockViewModel());

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Column(
        children: [
          Obx(() => viewModel.state.isBusy
              ? Text('busy')
              : viewModel.state.isError
                  ? Text('error')
                  : Text('idle')),
          FlatButton(
            key: ValueKey('busy_button'),
            onPressed: () => viewModel.state = BusyState(),
            child: Text('SET BUSY'),
          ),
          FlatButton(
            key: ValueKey('idle_button'),
            onPressed: () => viewModel.state = IdleState(),
            child: Text('SET IDLE'),
          ),
          FlatButton(
            key: ValueKey('error_button'),
            onPressed: () => viewModel.state =
                ErrorState(failure: GenericFailure(message: 'test')),
            child: Text('SET ERROR'),
          ),
        ],
      ));
}

void main() {
  testWidgets(
      'should register view model on create and show view with idle state',
      (WidgetTester tester) async {
    await WidgetTestUtils.createWidget(tester, _MockView());
    expect(ViewModel.find<_MockViewModel>() != null, true);
    expect(Get.isRegistered<_MockViewModel>(), true);
    expect(WidgetTestUtils.findByText('idle'), findsOneWidget);
  });

  testWidgets('should update view when view model state change to busy',
      (WidgetTester tester) async {
    await WidgetTestUtils.createWidget(tester, _MockView());
    await tester.tap(find.byKey(ValueKey('busy_button')));
    await tester.pump();
    expect(WidgetTestUtils.findByText('idle'), findsNothing);
    expect(WidgetTestUtils.findByText('busy'), findsOneWidget);
  });

  testWidgets('should update view when view model state change to error',
      (WidgetTester tester) async {
    await WidgetTestUtils.createWidget(tester, _MockView());
    await tester.tap(find.byKey(ValueKey('error_button')));
    await tester.pump();
    expect(WidgetTestUtils.findByText('idle'), findsNothing);
    expect(WidgetTestUtils.findByText('error'), findsOneWidget);
  });

  testWidgets('should update view when view model state change back and forth',
      (WidgetTester tester) async {
    await WidgetTestUtils.createWidget(tester, _MockView());
    await tester.tap(find.byKey(ValueKey('error_button')));
    await tester.pump();
    expect(WidgetTestUtils.findByText('idle'), findsNothing);
    expect(WidgetTestUtils.findByText('error'), findsOneWidget);
    await tester.tap(find.byKey(ValueKey('busy_button')));
    await tester.pump();
    expect(WidgetTestUtils.findByText('error'), findsNothing);
    expect(WidgetTestUtils.findByText('busy'), findsOneWidget);
    await tester.tap(find.byKey(ValueKey('idle_button')));
    await tester.pump();
    expect(WidgetTestUtils.findByText('busy'), findsNothing);
    expect(WidgetTestUtils.findByText('idle'), findsOneWidget);
  });
}

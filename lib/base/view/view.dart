import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg/base/view/view_model.dart';

abstract class _BaseViewComponents<T extends ViewModel> {
  void initState(BuildContext context);
  Widget build(BuildContext context);
  Widget fixedChild(BuildContext context);
}

abstract class View<T extends ViewModel> extends StatefulWidget
    implements _BaseViewComponents<T> {
  final T viewModel;

  View({@required this.viewModel, Key key})
      : assert(viewModel != null),
        super(key: key);

  @override
  Widget fixedChild(BuildContext context) => null;

  @override
  void initState(BuildContext context) {}

  @override
  State<StatefulWidget> createState() => _BaseState();
}

class _BaseState<T extends ViewModel> extends State<View> {
  @override
  void initState() {
    widget.initState(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<T>.value(
        value: widget.viewModel,
        child: Consumer<T>(
          builder: (context, __, child) => widget.build(context),
          child: widget.fixedChild(context),
        ),
      );
}

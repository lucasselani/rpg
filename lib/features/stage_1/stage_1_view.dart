import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rpg/base/view/view.dart';
import 'package:rpg/features/common/screens/busy_screen.dart';
import 'package:rpg/features/common/widgets/map_widget.dart';
import 'package:rpg/features/stage_1/stage_1_view_model.dart';

class Stage1View extends View<Stage1ViewModel> {
  Stage1View() : super(Stage1ViewModel());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: viewModel.state.isBusy
          ? BusyScreen()
          : MapWidget(
              map: viewModel.stage.map, width: size.width, height: size.height),
    );
  }
}

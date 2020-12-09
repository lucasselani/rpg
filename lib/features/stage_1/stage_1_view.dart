import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rpg/base/view/view.dart';
import 'package:rpg/core/maps/stage_1/stage_1_map.dart';
import 'package:rpg/features/stage_1/stage_1_view_model.dart';
import 'package:rpg/features/widgets/map_widget.dart';

class Stage1View extends View<Stage1ViewModel> {
  Stage1View() : super(Stage1ViewModel());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: MapWidget(map: Stage1Map(), width: size.width, height: size.height),
    );
  }
}

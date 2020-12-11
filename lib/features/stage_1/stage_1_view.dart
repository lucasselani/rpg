import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rpg/base/view/view.dart';
import 'package:rpg/core/characters/player/player.dart';
import 'package:rpg/core/stages/base/stage.dart';
import 'package:rpg/core/stages/stage_1/stage_1.dart';
import 'package:rpg/features/stage_1/stage_1_view_model.dart';
import 'package:rpg/features/widgets/map_widget.dart';

class Stage1View extends View<Stage1ViewModel> {
  final Stage _stage;

  Stage1View()
      : _stage = Stage1(player: Player()),
        super(Stage1ViewModel());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: MapWidget(map: _stage.map, width: size.width, height: size.height),
    );
  }
}

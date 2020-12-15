import 'package:flutter/material.dart';
import 'package:rpg/base/view/view.dart';
import 'package:rpg/core/characters/base/character.dart';
import 'package:rpg/core/characters/player/player.dart';
import 'package:rpg/core/scenario/stage.dart';
import 'package:rpg/features/common/view_models/stage_view_model.dart';
import 'package:rpg/features/common/views/player_view.dart';
import 'package:rpg/features/common/widgets/map_widget.dart';
import 'package:rpg/features/common/widgets/token_widget.dart';

class StageView extends View<StageViewModel> {
  final Stage stage;
  final double width;
  final double height;

  StageView({@required this.stage, @required this.width, @required this.height})
      : super(viewModel: StageViewModel());

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          constraints: BoxConstraints.tight(Size(width, height)),
          child: Stack(
            children: [
              MapWidget(
                stage: stage,
              ),
              ...allCharacters
            ],
          ),
        ),
      );

  List<Widget> get allCharacters => stage.allCharacters
      .map((character) => _wrapInPositioned(
            x: character.xPos,
            y: character.yPos,
            child: _buildCharacter(character),
          ))
      .toList();

  Widget _buildCharacter(Character character) => character is Player
      ? PlayerView(player: character, stage: stage)
      : TokenWidget(character: character, stage: stage);

  Widget _wrapInPositioned({int x, int y, Widget child}) => Positioned(
        child: child,
        left: (x / (stage.map.xSize - 1)) * width,
        top: (y / (stage.map.ySize - 1)) * height,
      );
}

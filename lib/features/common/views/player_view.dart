import 'package:flutter/src/widgets/framework.dart';
import 'package:rpg/base/view/view.dart';
import 'package:rpg/core/characters/player/player.dart';
import 'package:rpg/core/scenario/stage.dart';
import 'package:rpg/features/common/view_models/player_view_model.dart';
import 'package:rpg/features/common/widgets/token_widget.dart';

class PlayerView extends View<PlayerViewModel> {
  final Player player;
  final Stage stage;

  PlayerView({this.player, this.stage}) : super(viewModel: PlayerViewModel());

  @override
  Widget build(BuildContext context) =>
      TokenWidget(character: player, stage: stage);
}

import 'package:rpg/base/view/view_model.dart';
import 'package:rpg/core/characters/enemies/orc.dart';
import 'package:rpg/core/characters/player/player.dart';
import 'package:rpg/core/maps/arena_map.dart';
import 'package:rpg/core/scenario/stage.dart';

class Stage1ViewModel extends ViewModel {
  final Stage stage = Stage(
    maxRowShown: 5,
    maxColumnShown: 10,
    map: ArenaMap(),
    player: Player(
      currentX: 1,
      currentY: 5,
    ),
    enemies: [
      Orc(currentX: 8, currentY: 4),
    ],
  );
}

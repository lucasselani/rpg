import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:rpg/core/characters/base/character.dart';
import 'package:rpg/core/characters/player/player.dart';
import 'package:rpg/core/scenario/tiled_map.dart';

class Stage {
  final TiledMap map;
  final Player player;
  final List<Character> enemies;
  final int maxRowShown;
  final int maxColumnShown;

  Stage(
      {@required this.map,
      @required this.player,
      @required this.maxRowShown,
      @required this.maxColumnShown,
      List<Character> enemies})
      : assert(player != null),
        assert(map != null),
        assert(maxRowShown != null && maxRowShown > 0),
        assert(maxColumnShown != null && maxColumnShown > 0),
        enemies = enemies ?? [];

  Character characterAt({@required int x, @required int y}) {
    assert(x >= 0 && y >= 0);
    final characters = [player, ...enemies];
    final charactersAt = characters
        .where((character) => character.xPos == x && character.yPos == y);
    assert(charactersAt.isEmpty || charactersAt.length == 1);
    return charactersAt.isNotEmpty ? charactersAt.first : null;
  }

  List<Character> get allCharacters => [player, ...enemies];

  Size getStageSize(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Size(
      screenSize.width * (map.xSize / maxColumnShown),
      screenSize.height * (map.ySize / maxRowShown),
    );
  }

  double getTileSize(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return min(
      screenSize.width / maxColumnShown,
      screenSize.height / maxRowShown,
    );
  }
}

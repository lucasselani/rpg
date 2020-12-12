import 'package:flutter/foundation.dart';
import 'package:rpg/core/characters/base/character.dart';
import 'package:rpg/core/characters/player/player.dart';
import 'package:rpg/core/maps/base/tiled_map.dart';

abstract class Stage {
  final TiledMap map;
  final Player player;
  final List<Character> enemies;

  Stage({@required this.map, @required this.player, List<Character> enemies})
      : assert(player != null),
        assert(map != null),
        enemies = enemies ?? [];
}

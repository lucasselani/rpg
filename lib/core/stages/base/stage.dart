import 'package:rpg/core/characters/base/character.dart';
import 'package:rpg/core/maps/base/tiled_map.dart';

abstract class Stage {
  final TiledMap map;
  final Character player;
  final List<Character> enemies;

  Stage(this.map, this.player, this.enemies);
}

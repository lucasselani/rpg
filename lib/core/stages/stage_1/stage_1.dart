import 'package:flutter/foundation.dart';
import 'package:rpg/core/characters/base/character.dart';
import 'package:rpg/core/maps/stage_1/stage_1_map.dart';
import 'package:rpg/core/stages/base/stage.dart';

class Stage1 extends Stage {
  Stage1({@required Character player, List<Character> enemies})
      : super(map: Stage1Map(), player: player, enemies: enemies);
}

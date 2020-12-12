import 'package:flutter_test/flutter_test.dart';
import 'package:rpg/core/characters/base/character.dart';
import 'package:rpg/core/characters/player/player.dart';
import 'package:rpg/core/maps/base/tiled_map.dart';
import 'package:rpg/core/stages/base/stage.dart';
import 'package:rpg/core/tiles/can_pass/grass.dart';
import 'package:rpg/core/tiles/impassable/wall.dart';

import 'tiled_map_test.dart';

class MockStage extends Stage {
  MockStage({TiledMap map, Player player, List<Character> enemies})
      : super(map: map, player: player, enemies: enemies);
}

void main() {
  final map = [
    [Grass(), Grass(), Grass()],
    [Grass(), Wall(), Grass()],
    [Grass(), Grass(), Wall()],
  ];

  test('should have correct initial values', () {
    final stage = MockStage(map: MockMap(map, x: 3, y: 3), player: Player());
    expect(stage.player is Player, true);
    expect(stage.enemies, []);
    expect(stage.enemies.length, 0);
    expect(stage.map.xSize, 3);
    expect(stage.map.ySize, 3);
  });

  test('should throw assertion error when creating stage with invalid args',
      () {
    final noPlayerStage =
        () => MockStage(map: MockMap(map, x: 3, y: 3), player: null);
    final noMapStage = () => MockStage(map: null, player: Player());
    expect(noPlayerStage, throwsAssertionError);
    expect(noMapStage, throwsAssertionError);
  });
}

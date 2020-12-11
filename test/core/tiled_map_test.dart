import 'package:flutter_test/flutter_test.dart';
import 'package:rpg/core/maps/base/tiled_map.dart';
import 'package:rpg/core/tiles/base/tile.dart';
import 'package:rpg/core/tiles/can_pass/grass.dart';
import 'package:rpg/core/tiles/impassable/wall.dart';

class _MockMap extends TiledMap {
  _MockMap(List<List<Tile>> tiles) : super(tiles);

  @override
  int get xSize => 2;

  @override
  int get ySize => 2;
}

void main() {
  test('should create 2x2 graph from list<list<tile>>', () {
    final map = _MockMap([
      [Grass(), Grass()],
      [Wall(), Wall()]
    ]);
    expect(map.xSize == 2, true);
    expect(map.ySize == 2, true);
  });

  test('should get right tile and position', () {
    final map = _MockMap([
      [Grass(), Grass()],
      [Grass(), Wall()]
    ]);
    final vertex = map.vertexAt(x: 1, y: 1);
    expect(vertex.xPos == 1, true);
    expect(vertex.yPos == 1, true);
    expect(vertex.tile is Wall, true);
    expect(vertex.tile is Grass, false);
  });

  test('should throw exception when map is null', () {
    expect(() => _MockMap(null), throwsAssertionError);
  });

  test('should throw exception when map has different size than given x', () {
    final mapCreator = () => _MockMap([
          [Grass()],
          [Wall()]
        ]);
    expect(mapCreator, throwsAssertionError);
  });

  test('should throw exception when map has different size than given y', () {
    final mapCreator = () => _MockMap([
          [Grass(), Wall()]
        ]);
    expect(mapCreator, throwsAssertionError);
  });
}

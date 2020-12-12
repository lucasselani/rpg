import 'package:flutter_test/flutter_test.dart';
import 'package:rpg/core/maps/base/tiled_map.dart';
import 'package:rpg/core/tiles/base/tile.dart';
import 'package:rpg/core/tiles/can_pass/grass.dart';
import 'package:rpg/core/tiles/impassable/wall.dart';
import 'package:collection/collection.dart';

class _MockMap extends TiledMap {
  final int x;
  final int y;
  _MockMap(List<List<Tile>> tiles, {this.x = 2, this.y = 2}) : super(tiles);

  @override
  int get xSize => x;

  @override
  int get ySize => y;
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

  test('should designate neighboor correctly', () {
    final map = _MockMap([
      [Grass(), Grass(), Grass()],
      [Grass(), Grass(), Grass()],
      [Grass(), Grass(), Grass()],
    ], x: 3, y: 3);
    final vertex00 = map.vertexAt(x: 0, y: 0);
    final vertex10 = map.vertexAt(x: 1, y: 0);
    final vertex20 = map.vertexAt(x: 2, y: 0);
    final vertex01 = map.vertexAt(x: 0, y: 1);
    final vertex11 = map.vertexAt(x: 1, y: 1);
    final vertex21 = map.vertexAt(x: 2, y: 1);
    final vertex02 = map.vertexAt(x: 0, y: 2);
    final vertex12 = map.vertexAt(x: 1, y: 2);
    final vertex22 = map.vertexAt(x: 2, y: 2);
    final eq = DeepCollectionEquality.unordered().equals;
    expect(
        eq(
          vertex00.knownNeighboors,
          [vertex01, vertex10, vertex11],
        ),
        true);
    expect(
        eq(
          vertex10.knownNeighboors,
          [vertex00, vertex01, vertex11, vertex21, vertex20],
        ),
        true);
    expect(
        eq(
          vertex20.knownNeighboors,
          [vertex10, vertex11, vertex21],
        ),
        true);
    expect(
        eq(
          vertex01.knownNeighboors,
          [vertex00, vertex10, vertex11, vertex12, vertex02],
        ),
        true);
    expect(
        eq(
          vertex11.knownNeighboors,
          [
            vertex00,
            vertex10,
            vertex20,
            vertex01,
            vertex21,
            vertex02,
            vertex12,
            vertex22
          ],
        ),
        true);
    expect(
        eq(
          vertex21.knownNeighboors,
          [vertex20, vertex10, vertex11, vertex12, vertex22],
        ),
        true);
    expect(
        eq(
          vertex02.knownNeighboors,
          [vertex01, vertex11, vertex12],
        ),
        true);
    expect(
        eq(
          vertex12.knownNeighboors,
          [vertex02, vertex01, vertex11, vertex21, vertex22],
        ),
        true);
    expect(
        eq(
          vertex22.knownNeighboors,
          [vertex12, vertex11, vertex21],
        ),
        true);
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

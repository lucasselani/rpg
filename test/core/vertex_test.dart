import 'package:flutter_test/flutter_test.dart';
import 'package:rpg/core/maps/base/vertex.dart';
import 'package:rpg/core/tiles/can_pass/grass.dart';
import 'package:rpg/core/tiles/impassable/wall.dart';

void main() {
  test('should save correct values for position and tile', () {
    final vertex = Vertex(tile: Grass(), xPos: 0, yPos: 0);
    expect(vertex.xPos == 0, true);
    expect(vertex.yPos == 0, true);
    expect(vertex.tile is Grass, true);
  });

  test('should be equal if position is equal even though tile is different',
      () {
    final vertex = Vertex(tile: Grass(), xPos: 0, yPos: 0);
    final other = Vertex(tile: Wall(), xPos: 0, yPos: 0);
    expect(vertex == other, true);
  });

  test('should only add adjancent vertex to neighboors', () {
    final vertex = Vertex(tile: Grass(), xPos: 0, yPos: 0);

    final adjacentY = Vertex(tile: Wall(), xPos: 0, yPos: 1);
    vertex.addNeighboor(adjacentY);
    expect(vertex.isAdjacent(adjacentY), true);

    final adjacentX = Vertex(tile: Wall(), xPos: 1, yPos: 0);
    vertex.addNeighboor(adjacentX);
    expect(vertex.isAdjacent(adjacentX), true);

    final nonAdjacent = Vertex(tile: Wall(), xPos: 2, yPos: 2);
    expect(() => vertex.addNeighboor(nonAdjacent), throwsAssertionError);
    expect(vertex.isAdjacent(nonAdjacent), false);

    expect(vertex.knownNeighboors.length == 2, true);
  });

  test('should not add neighboor direct to set', () {
    final vertex = Vertex(tile: Grass(), xPos: 0, yPos: 0);
    final adjacent = Vertex(tile: Wall(), xPos: 0, yPos: 1);
    expect(() => vertex.knownNeighboors.add(adjacent), throwsUnsupportedError);
  });
}

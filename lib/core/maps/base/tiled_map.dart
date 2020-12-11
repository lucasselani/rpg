import 'package:rpg/core/maps/base/vertex.dart';
import 'package:rpg/core/tiles/base/tile.dart';

abstract class TiledMap {
  List<Vertex> _vertices;

  int get xSize;
  int get ySize;

  TiledMap(List<List<Tile>> tiles) {
    _assertTiles(tiles);
    _createMap(tiles);
  }

  Vertex vertexAt({int x = 0, int y = 0}) =>
      _vertices.firstWhere((vertex) => vertex.xPos == x && vertex.yPos == y,
          orElse: () => null);

  int get area => xSize * ySize;

  void onEachVertex(void Function(Vertex vertex) onVertex) =>
      _vertices.forEach((vertex) => onVertex(vertex));

  void _assertTiles(List<List<Tile>> tiles) {
    assert(tiles != null);
    assert(tiles.length == ySize);
    for (var row in tiles) {
      assert(row.length == xSize);
    }
  }

  void _createMap(List<List<Tile>> tiles) {
    _vertices = <Vertex>[];
    for (var y = 0; y < ySize; y++) {
      for (var x = 0; x < xSize; x++) {
        _vertices.add(Vertex(tile: tiles[y][x], xPos: x, yPos: y));
      }
    }
    onEachVertex((vertex) => _findNeighboors(vertex));
  }

  void _findNeighboors(Vertex current) {
    // Left neighboor
    if (current.xPos - 1 >= 0) {
      final neighboor = vertexAt(x: current.xPos - 1, y: current.yPos);
      current.addNeighboor(neighboor);
    }
    // Right neighboor
    if (current.xPos + 1 < xSize) {
      final neighboor = vertexAt(x: current.xPos + 1, y: current.yPos);
      current.addNeighboor(neighboor);
    }
    // Top neighboor
    if (current.yPos - 1 >= 0) {
      final neighboor = vertexAt(x: current.xPos, y: current.yPos - 1);
      current.addNeighboor(neighboor);
    }
    // Bottom neighboor
    if (current.yPos + 1 < ySize) {
      final neighboor = vertexAt(x: current.xPos, y: current.yPos + 1);
      current.addNeighboor(neighboor);
    }
  }
}

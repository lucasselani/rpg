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
    _findNeighboors();
  }

  void _findNeighboors() {
    var remainingVertices = [..._vertices];
    _vertices.forEach((current) {
      remainingVertices.forEach((probe) {
        if (current.isAdjacent(probe)) {
          current.addNeighboor(probe);
          probe.addNeighboor(current);
        }
      });
      remainingVertices.remove(current);
    });
  }
}

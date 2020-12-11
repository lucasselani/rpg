import 'package:rpg/core/tiles/base/node.dart';
import 'package:rpg/core/tiles/base/tile.dart';

abstract class TiledMap {
  List<Node> _nodes;

  int get xSize;
  int get ySize;

  TiledMap(List<List<Tile>> tiles) {
    _assertTiles(tiles);
    _createMap(tiles);
  }

  Node nodeAt({int x = 0, int y = 0}) =>
      _nodes.firstWhere((node) => node.xPos == x && node.yPos == y,
          orElse: () => null);

  int get area => xSize * ySize;

  void onEachNode(void Function(Node node) onNode) =>
      _nodes.forEach((node) => onNode(node));

  void _assertTiles(List<List<Tile>> tiles) {
    assert(tiles.length == ySize);
    for (var row in tiles) {
      assert(row.length == xSize);
    }
  }

  void _createMap(List<List<Tile>> tiles) {
    _nodes = <Node>[];
    for (var y = 0; y < ySize; y++) {
      for (var x = 0; x < xSize; x++) {
        _nodes.add(Node(tile: tiles[y][x], xPos: x, yPos: y));
      }
    }
    onEachNode((node) => _findNeighboors(node));
  }

  void _findNeighboors(Node current) {
    // Left neighboor
    if (current.xPos - 1 >= 0) {
      final neighboor = nodeAt(x: current.xPos - 1, y: current.yPos);
      current.neighboors.add(neighboor);
    }
    // Right neighboor
    if (current.xPos + 1 < xSize) {
      final neighboor = nodeAt(x: current.xPos + 1, y: current.yPos);
      current.neighboors.add(neighboor);
    }
    // Top neighboor
    if (current.yPos - 1 >= 0) {
      final neighboor = nodeAt(x: current.xPos, y: current.yPos - 1);
      current.neighboors.add(neighboor);
    }
    // Bottom neighboor
    if (current.yPos + 1 < ySize) {
      final neighboor = nodeAt(x: current.xPos, y: current.yPos + 1);
      current.neighboors.add(neighboor);
    }
  }
}

import 'package:rpg/core/tiles/base/tile.dart';

abstract class TiledMap {
  final List<List<Tile>> tiles;
  int get xSize;
  int get ySize;

  TiledMap(this.tiles) {
    _assertMap();
  }

  Tile getTile({int x = 0, int y = 0}) => tiles[y][x];

  int get area => xSize * ySize;

  void _assertMap() {
    assert(tiles.length == ySize);
    for (var row in tiles) {
      assert(row.length == xSize);
    }
  }
}

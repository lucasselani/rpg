import 'package:rpg/core/maps/base/tiled_map.dart';
import 'package:rpg/core/tiles/can_pass/grass.dart';
import 'package:rpg/core/tiles/impassable/wall.dart';

class Stage1Map extends TiledMap {
  Stage1Map()
      : super([
          [
            Wall(),
            Wall(),
            Wall(),
          ],
          [
            Grass(),
            Grass(),
            Grass(),
          ],
          [
            Grass(),
            Grass(),
            Grass(),
          ],
          [
            Wall(),
            Wall(),
            Wall(),
          ],
        ]);

  @override
  int get xSize => 3;

  @override
  int get ySize => 4;
}

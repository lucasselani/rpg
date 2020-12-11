import 'package:rpg/core/maps/base/tiled_map.dart';
import 'package:rpg/core/tiles/can_pass/grass.dart';

class Stage1Map extends TiledMap {
  Stage1Map()
      : super([
          [
            Grass(),
            Grass(),
            Grass(),
            Grass(),
            Grass(),
          ],
          [
            Grass(),
            Grass(),
            Grass(),
            Grass(),
            Grass(),
          ],
          [
            Grass(),
            Grass(),
            Grass(),
            Grass(),
            Grass(),
          ],
          [
            Grass(),
            Grass(),
            Grass(),
            Grass(),
            Grass(),
          ],
          [
            Grass(),
            Grass(),
            Grass(),
            Grass(),
            Grass(),
          ],
        ]);

  @override
  int get xSize => 5;

  @override
  int get ySize => 5;
}

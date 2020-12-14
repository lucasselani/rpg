import 'package:rpg/base/view/view_model.dart';
import 'package:rpg/core/characters/player/player.dart';
import 'package:rpg/core/maps/arena_map.dart';
import 'package:rpg/core/scenario/stage.dart';

class Stage1ViewModel extends ViewModel {
  final Stage stage = Stage(map: ArenaMap(), player: Player());
}

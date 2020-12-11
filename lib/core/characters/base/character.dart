import 'package:rpg/core/capabilities/move/movable.dart';

class Character with Movable {
  Character({int currentX = 0, int currentY = 0}) {
    assert(currentX != null && currentX >= 0);
    assert(currentY != null && currentY >= 0);
    xPos = currentX;
    yPos = currentY;
  }
}

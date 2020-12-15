import 'package:flutter/material.dart';
import 'package:rpg/core/capabilities/move/movable.dart';

class Character with Movable {
  final Color color;

  Character({int currentX = 0, int currentY = 0, this.color}) {
    assert(currentX != null && currentX >= 0);
    assert(currentY != null && currentY >= 0);
    xPos = currentX;
    yPos = currentY;
  }
}

import 'package:flutter/material.dart';
import 'package:rpg/core/characters/base/character.dart';

class Orc extends Character {
  Orc({int currentX = 0, int currentY = 0})
      : super(currentX: currentX, currentY: currentY, color: Colors.red);
}

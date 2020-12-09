import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rpg/core/tiles/base/tile.dart';

class Grass implements Tile {
  @override
  bool get canPass => true;

  @override
  Color get color => Colors.green;
}

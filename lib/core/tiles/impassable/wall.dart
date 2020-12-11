import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rpg/core/tiles/base/tile.dart';

class Wall implements Tile {
  @override
  bool get canPass => false;

  @override
  Color get color => Colors.grey;
}

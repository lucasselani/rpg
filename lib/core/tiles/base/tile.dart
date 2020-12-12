import 'package:flutter/material.dart';

abstract class Tile {
  bool get canPass;
  Color get color;
}

class AnyTile implements Tile {
  @override
  bool get canPass => true;

  @override
  Color get color => Colors.transparent;

  const AnyTile();
}

import 'package:flutter/material.dart';
import 'package:rpg/core/tiles/base/tile.dart';

class TileWidget extends StatelessWidget {
  final Tile tile;

  const TileWidget({Key key, @required this.tile}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Container(constraints: BoxConstraints.expand(), color: tile.color);
}

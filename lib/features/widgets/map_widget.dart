import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rpg/core/maps/base/tiled_map.dart';
import 'package:rpg/features/widgets/tile_widget.dart';

class MapWidget extends StatelessWidget {
  final TiledMap map;
  final double width;
  final double height;

  const MapWidget(
      {Key key,
      @required this.map,
      @required this.width,
      @required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Container(
            constraints: BoxConstraints.tight(Size(width, height)),
            child: Column(
                children: List<Row>.generate(
                    map.ySize, (yIndex) => _createRow(context, yIndex))),
          ),
        ),
      );

  Row _createRow(BuildContext context, int yIndex) => Row(
      children: List<Widget>.generate(map.xSize,
          (xIndex) => _createTile(context, yIndex: yIndex, xIndex: xIndex)));

  Widget _createTile(BuildContext context, {int yIndex = 0, int xIndex = 0}) =>
      Container(
        constraints: BoxConstraints.tight(
            Size.square(min(width / map.xSize, height / map.ySize))),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black87, width: 1)),
        child: Center(
          child: TileWidget(
            tile: map.nodeAt(x: xIndex, y: yIndex).tile,
          ),
        ),
      );
}

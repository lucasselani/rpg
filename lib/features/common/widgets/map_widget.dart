import 'package:flutter/material.dart';
import 'package:rpg/core/scenario/stage.dart';
import 'package:rpg/features/common/widgets/tile_widget.dart';

class MapWidget extends StatelessWidget {
  final Stage stage;

  const MapWidget({
    Key key,
    @required this.stage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stageSize = stage.getStageSize(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: stageSize.width,
        height: stageSize.height,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Column(
            children: List<Row>.generate(
              stage.map.ySize,
              (yIndex) =>
                  _createRow(context, yIndex, stage.getTileSize(context)),
            ),
          ),
        ),
      ),
    );
  }

  Row _createRow(BuildContext context, int yIndex, double tileSize) => Row(
      children: List<Widget>.generate(
          stage.map.xSize,
          (xIndex) => _createTile(context,
              yIndex: yIndex, xIndex: xIndex, tileSize: tileSize)));

  Widget _createTile(BuildContext context,
      {int yIndex = 0, int xIndex = 0, double tileSize = 0.0}) {
    final vertex = stage.map.vertexAt(x: xIndex, y: yIndex);
    return Container(
      constraints: BoxConstraints.tight(Size.square(tileSize)),
      decoration: vertex.tile.canPass
          ? BoxDecoration(border: Border.all(color: Colors.black87, width: 1))
          : null,
      child: TileWidget(
        tile: vertex.tile,
      ),
    );
  }
}

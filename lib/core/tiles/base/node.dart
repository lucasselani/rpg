import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'package:rpg/core/tiles/base/tile.dart';

class Node {
  final Tile tile;
  final int xPos;
  final int yPos;
  final Set<Node> neighboors = {};

  Node({@required this.tile, @required this.xPos, @required this.yPos})
      : assert(tile != null),
        assert(xPos != null && xPos >= 0),
        assert(yPos != null && yPos >= 0);

  bool isAdjacent(Node other) => neighboors.contains(other);

  @override
  int get hashCode => hash2(xPos, yPos);

  @override
  bool operator ==(other) =>
      other is Node && other.xPos == xPos && other.yPos == yPos;

  @override
  String toString() => '($xPos,$yPos)';
}

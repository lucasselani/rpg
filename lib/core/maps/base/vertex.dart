import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'package:rpg/core/tiles/base/tile.dart';

class Vertex {
  final Tile tile;
  final int xPos;
  final int yPos;
  final Set<Vertex> _neighboors = {};
  List<Vertex> get knownNeighboors => List.unmodifiable(_neighboors);

  Vertex({@required this.tile, @required this.xPos, @required this.yPos})
      : assert(tile != null),
        assert(xPos != null && xPos >= 0),
        assert(yPos != null && yPos >= 0);

  bool isAdjacent(Vertex other) => distanceBetween(other) == 1 && this != other;

  int distanceBetween(Vertex other) => max(
        (other.xPos - xPos).abs(),
        (other.yPos - yPos).abs(),
      );

  void addNeighboor(Vertex neighboor) {
    assert(isAdjacent(neighboor));
    _neighboors.add(neighboor);
  }

  @override
  int get hashCode => hash2(xPos, yPos);

  @override
  bool operator ==(other) =>
      other is Vertex && other.xPos == xPos && other.yPos == yPos;

  @override
  String toString() => '($xPos,$yPos)';
}

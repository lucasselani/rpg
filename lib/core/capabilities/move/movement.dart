import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'package:rpg/core/scenario/vertex.dart';

class Movement {
  final Vertex origin;
  final Vertex destination;
  final List<Vertex> path;

  Movement.unit({@required this.origin, @required this.destination})
      : assert(origin != null),
        assert(destination != null),
        assert(origin.tile.canPass),
        assert(destination.tile.canPass),
        assert(origin.isAdjacent(destination)),
        path = [] {
    path.addAll([origin, destination]);
  }

  Movement._copy(
      {@required Vertex newDestiny, Vertex origin, List<Vertex> oldPath})
      : origin = origin,
        destination = newDestiny,
        path = [...oldPath, newDestiny];

  Movement to(Vertex adjacentVertex) {
    assert(adjacentVertex != null);
    assert(adjacentVertex.tile.canPass);
    assert(destination.isAdjacent(adjacentVertex));
    assert(!path.contains(adjacentVertex));
    return Movement._copy(
      newDestiny: adjacentVertex,
      origin: origin,
      oldPath: path,
    );
  }

  int get distance => path.length - 1;

  bool containsInPath({int x = 0, int y = 0}) =>
      path.contains(Vertex(xPos: x, yPos: y));

  @override
  String toString() => path.map((vertex) => vertex.toString()).join(' -> ');

  @override
  int get hashCode => hash2(origin.hashCode, destination.hashCode);

  @override
  bool operator ==(other) =>
      other is Movement &&
      other.origin == origin &&
      other.destination == destination;
}

import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'package:rpg/core/maps/base/vertex.dart';

class Movement {
  final Vertex source;
  final Vertex destiny;
  final List<Vertex> path;

  Movement.unit({@required this.source, @required this.destiny})
      : assert(source != null),
        assert(destiny != null),
        assert(source.tile.canPass),
        assert(destiny.tile.canPass),
        assert(source.isAdjacent(destiny)),
        path = [] {
    path.addAll([source, destiny]);
  }

  Movement._copy(
      {@required Vertex newDestiny, Vertex source, List<Vertex> oldPath})
      : source = source,
        destiny = newDestiny,
        path = [...oldPath, newDestiny];

  Movement to(Vertex adjacentVertex) {
    assert(adjacentVertex != null);
    assert(adjacentVertex.tile.canPass);
    assert(destiny.isAdjacent(adjacentVertex));
    assert(!path.contains(adjacentVertex));
    return Movement._copy(
      newDestiny: adjacentVertex,
      source: source,
      oldPath: path,
    );
  }

  int get distance => path.length - 1;

  @override
  String toString() => path.map((vertex) => vertex.toString()).join(' -> ');

  @override
  int get hashCode => hash2(source.hashCode, destiny.hashCode);

  @override
  bool operator ==(other) =>
      other is Movement && other.source == source && other.destiny == destiny;
}

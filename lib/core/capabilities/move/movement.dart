import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'package:rpg/core/tiles/base/node.dart';

class Movement {
  final Node source;
  final Node destiny;
  final List<Node> path;

  Movement.unit({@required this.source, @required this.destiny})
      : assert(source != null),
        assert(destiny != null),
        assert(source.isAdjacent(destiny)),
        path = [] {
    path.addAll([source, destiny]);
  }

  Movement._copy({Node newDestiny, Node source, List<Node> oldPath})
      : source = source,
        destiny = newDestiny,
        path = [...oldPath, newDestiny];

  Movement to(Node adjacentNode) {
    assert(destiny.isAdjacent(adjacentNode));
    return Movement._copy(
      newDestiny: adjacentNode,
      source: source,
      oldPath: path,
    );
  }

  int get distance => path.length - 1;

  @override
  String toString() => path.map((node) => node.toString()).join(' -> ');

  @override
  int get hashCode => hash2(source.hashCode, destiny.hashCode);

  @override
  bool operator ==(other) =>
      other is Movement && other.source == source && other.destiny == destiny;
}

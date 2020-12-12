import 'package:flutter/foundation.dart';
import 'package:rpg/core/capabilities/move/movement.dart';
import 'package:rpg/core/stages/base/stage.dart';
import 'package:rpg/core/maps/base/vertex.dart';

class Movable {
  int xPos = 0;
  int yPos = 0;

  void moveTo({Movement movement, int maxSteps = 0}) {
    assert(maxSteps >= 0);
    assert(movement.distance <= maxSteps);
    assert(xPos == movement.origin.xPos);
    assert(yPos == movement.origin.yPos);
    xPos = movement.destination.xPos;
    yPos = movement.destination.yPos;
  }

  List<Movement> possibleMovements(Stage stage, {int maxDistance = 0}) {
    assert(stage != null && maxDistance >= 0);
    if (maxDistance == 0) return List.unmodifiable([]);
    final currentVertex = stage.map.vertexAt(x: xPos, y: yPos);
    final initialMovements =
        _findInitialMovements(origin: currentVertex, stage: stage);
    final allMovements = _findNextMovements(
        movements: initialMovements, stage: stage, maxDistance: maxDistance);
    return List.unmodifiable(allMovements);
  }

  Set<Movement> _findInitialMovements({
    @required Vertex origin,
    @required Stage stage,
  }) {
    final initialMovements = <Movement>{};
    final possibleVertexs = _possibleVertices(stage: stage, origin: origin);
    possibleVertexs.forEach((destiny) {
      final movement = Movement.unit(origin: origin, destination: destiny);
      initialMovements.add(movement);
    });
    return initialMovements;
  }

  Set<Movement> _findNextMovements({
    @required Set<Movement> movements,
    @required Stage stage,
    @required int maxDistance,
    int distance = 2,
  }) {
    assert(distance >= 2 && movements?.isNotEmpty == true);
    if (distance > maxDistance) return movements;
    final newMovements = <Movement>{};
    movements.forEach((movement) {
      final nextVertices =
          _possibleVertices(stage: stage, origin: movement.destination);
      nextVertices.forEach((vertex) {
        if (vertex != movement.origin) {
          newMovements.add(movement.to(vertex));
        }
      });
    });
    return _findNextMovements(
        movements: movements..addAll(newMovements),
        stage: stage,
        maxDistance: maxDistance,
        distance: distance + 1);
  }

  List<Vertex> _possibleVertices({Stage stage, Vertex origin}) {
    final verticesWithEnemies = stage.enemies
            ?.map((enemy) => stage.map.vertexAt(x: enemy.xPos, y: enemy.yPos))
            ?.toSet() ??
        <Vertex>{};
    return origin.knownNeighboors
        .where((vertex) =>
            vertex.tile.canPass &&
            origin != vertex &&
            !verticesWithEnemies
                .any((vertexWithEnemy) => vertexWithEnemy == vertex))
        .toList();
  }
}

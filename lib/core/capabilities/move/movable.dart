import 'package:flutter/foundation.dart';
import 'package:rpg/core/capabilities/move/movement.dart';
import 'package:rpg/core/stages/base/stage.dart';
import 'package:rpg/core/maps/base/vertex.dart';

class Movable {
  int xPos = 0;
  int yPos = 0;

  void moveTo({Movement movement, int maxSteps = 0}) {
    assert(maxSteps >= 0);
    assert(movement.source.xPos == xPos);
    assert(movement.source.yPos == yPos);
    assert(movement.distance <= maxSteps);
    xPos = movement.destiny.xPos;
    yPos = movement.destiny.yPos;
  }

  List<Movement> possibleMovements(Stage stage, {int maxDistance = 0}) {
    assert(stage != null && maxDistance >= 0);
    if (maxDistance == 0) return List.unmodifiable([]);
    final currentVertex = stage.map.vertexAt(x: xPos, y: yPos);
    final initialMovements =
        _findInitialMovements(source: currentVertex, stage: stage);
    final allMovements = _findNextMovements(
        movements: initialMovements, stage: stage, maxDistance: maxDistance);
    return List.unmodifiable(allMovements);
  }

  Set<Movement> _findInitialMovements({
    @required Vertex source,
    @required Stage stage,
  }) {
    final initialMovements = <Movement>{};
    final possibleVertexs = _possibleVertices(stage: stage, source: source);
    possibleVertexs.forEach((destiny) {
      final movement = Movement.unit(source: source, destiny: destiny);
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
          _possibleVertices(stage: stage, source: movement.destiny);
      nextVertices.forEach((vertex) {
        if (vertex != movement.source) {
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

  List<Vertex> _possibleVertices({Stage stage, Vertex source}) {
    final verticesWithEnemies = stage.enemies
        .map((enemy) => stage.map.vertexAt(x: enemy.xPos, y: enemy.yPos))
        .toSet();
    return source.knownNeighboors
        .where((vertex) =>
            vertex.tile.canPass &&
            source != vertex &&
            !verticesWithEnemies
                .any((vertexWithEnemy) => vertexWithEnemy == vertex))
        .toList();
  }
}

import 'package:flutter/foundation.dart';
import 'package:rpg/core/capabilities/move/movement.dart';
import 'package:rpg/core/stages/base/stage.dart';
import 'package:rpg/core/tiles/base/node.dart';

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

  List<Movement> possibleMoviments(Stage stage, {int maxDistance = 0}) {
    assert(stage != null && maxDistance >= 0);
    if (maxDistance == 0) return [];
    final currentNode = stage.map.nodeAt(x: xPos, y: yPos);
    final initialMoviments =
        _findInitialMoviments(source: currentNode, stage: stage);
    return _findNextMoviments(
            moviments: initialMoviments, stage: stage, maxDistance: maxDistance)
        .toList();
  }

  Set<Movement> _findInitialMoviments({
    @required Node source,
    @required Stage stage,
  }) {
    final initialMoviments = <Movement>{};
    final possibleNodes = _possibleNodes(stage: stage, source: source);
    possibleNodes.forEach((destiny) {
      final movement = Movement.unit(source: source, destiny: destiny);
      initialMoviments.add(movement);
    });
    return initialMoviments;
  }

  Set<Movement> _findNextMoviments({
    @required Set<Movement> moviments,
    @required Stage stage,
    @required int maxDistance,
    int distance = 2,
  }) {
    assert(distance >= 2 && moviments?.isNotEmpty == true);
    if (distance > maxDistance) return moviments;
    final newMoviments = <Movement>{};
    moviments.forEach((moviment) {
      final nextNodes = _possibleNodes(stage: stage, source: moviment.destiny);
      nextNodes.forEach((node) {
        if (node != moviment.source) {
          newMoviments.add(moviment.to(node));
        }
      });
    });
    return _findNextMoviments(
        moviments: moviments..addAll(newMoviments),
        stage: stage,
        maxDistance: maxDistance,
        distance: distance + 1);
  }

  List<Node> _possibleNodes({Stage stage, Node source}) {
    final nodesWithEnemies = stage.enemies
        .map((enemy) => stage.map.nodeAt(x: enemy.xPos, y: enemy.yPos))
        .toSet();
    return source.neighboors
        .where((node) =>
            node.tile.canPass &&
            source != node &&
            !nodesWithEnemies.any((nodeWithEnemy) => nodeWithEnemy == node))
        .toList();
  }
}

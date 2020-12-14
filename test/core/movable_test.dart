import 'package:flutter_test/flutter_test.dart';
import 'package:rpg/core/capabilities/move/movement.dart';
import 'package:rpg/core/characters/player/player.dart';
import 'package:rpg/core/scenario/tiled_map.dart';
import 'package:rpg/core/scenario/vertex.dart';
import 'package:rpg/core/scenario/stage.dart';
import 'package:rpg/core/tiles/can_pass/grass.dart';
import 'package:rpg/core/tiles/impassable/wall.dart';

import 'stage_test.dart';

void main() {
  final map = [
    [Grass(), Grass(), Grass()],
    [Grass(), Wall(), Grass()],
    [Grass(), Grass(), Wall()],
  ];
  Player player;
  Stage stage;

  List<Vertex> _getAllOrigins(List<Movement> movements) =>
      movements.map((mov) => mov.origin).toSet().toList();

  List<Vertex> _getAllDestinations(List<Movement> movements) =>
      movements.map((mov) => mov.destination).toSet().toList();

  Movement _createMovement({int originX, int originY, int destX, int destY}) =>
      Movement.unit(
          origin: Vertex(xPos: originX, yPos: originY),
          destination: Vertex(xPos: destX, yPos: destY));

  setUp(() {
    player = Player();
    stage = MockStage(
        player: player, map: TiledMap(tiles: map, xSize: 3, ySize: 3));
  });

  test('should create movable with initial values', () {
    expect(player.xPos, 0);
    expect(player.yPos, 0);
  });

  test('should find no movements with range 0', () {
    expect(player.possibleMovements(stage, maxDistance: 0), []);
  });
  test('should find possible movements with range 1', () {
    final movements = player.possibleMovements(stage, maxDistance: 1);
    expect(movements.length, 2);
    expect(movements.where((movement) => movement.path.length == 2).length, 2);

    final origins = _getAllOrigins(movements);
    expect(origins.length, 1);
    expect(origins.first.xPos, 0);
    expect(origins.first.yPos, 0);
    expect(origins.first.tile.canPass, true);

    final destinations = _getAllDestinations(movements);
    expect(destinations.where((dest) => dest.tile.canPass).length, 2);
    expect(destinations.length, 2);
    expect(
        destinations.contains(
          Vertex(xPos: 0, yPos: 1),
        ),
        true);
    expect(
        destinations.contains(
          Vertex(xPos: 1, yPos: 0),
        ),
        true);
  });

  test('should find possible movements with range 2', () {
    final movements = player.possibleMovements(stage, maxDistance: 2);
    expect(movements.length, 6);
    expect(movements.where((movement) => movement.path.length == 2).length, 2);
    expect(movements.where((movement) => movement.path.length == 3).length, 4);

    final origins = _getAllOrigins(movements);
    expect(origins.length, 1);
    expect(origins.first.xPos, 0);
    expect(origins.first.yPos, 0);
    expect(origins.first.tile.canPass, true);

    final destinations = _getAllDestinations(movements);
    expect(destinations.length, 6);
    expect(destinations.where((dest) => dest.tile.canPass).length, 6);
    //straght 1
    expect(
        destinations.contains(
          Vertex(xPos: 0, yPos: 1),
        ),
        true);
    expect(
        destinations.contains(
          Vertex(xPos: 1, yPos: 0),
        ),
        true);
    // straight 2
    expect(
        destinations.contains(
          Vertex(xPos: 2, yPos: 0),
        ),
        true);
    expect(
        destinations.contains(
          Vertex(xPos: 0, yPos: 2),
        ),
        true);
    // diagonal 2
    expect(
        destinations.contains(
          Vertex(xPos: 1, yPos: 2),
        ),
        true);
    expect(
        destinations.contains(
          Vertex(xPos: 2, yPos: 1),
        ),
        true);
  });

  test(
      'should throw assertion error when finding possible movements with wrong args',
      () {
    expect(() => player.possibleMovements(null), throwsAssertionError);
    expect(() => player.possibleMovements(stage, maxDistance: -1),
        throwsAssertionError);
  });

  test('should move to movement correctly', () {
    var movement = _createMovement(originX: 0, originY: 0, destX: 0, destY: 1);

    player.moveTo(movement: movement, maxSteps: 1);
    expect(player.xPos, 0);
    expect(player.yPos, 1);

    player.xPos = 0;
    player.yPos = 0;
    movement = movement.to(Vertex(xPos: 0, yPos: 2));
    player.moveTo(movement: movement, maxSteps: 2);
    expect(player.xPos, 0);
    expect(player.yPos, 2);

    player.xPos = 0;
    player.yPos = 0;
    movement = movement.to(Vertex(xPos: 0, yPos: 3));
    movement = movement.to(Vertex(xPos: 0, yPos: 4));
    player.moveTo(movement: movement, maxSteps: 4);
    expect(player.xPos, 0);
    expect(player.yPos, 4);
  });

  test('should throw assertion error when moving with wrong args', () {
    var movement = _createMovement(originX: 0, originY: 0, destX: 0, destY: 1);
    movement = movement.to(Vertex(xPos: 0, yPos: 2));
    expect(() => player.moveTo(movement: movement, maxSteps: 1),
        throwsAssertionError);
    expect(() => player.moveTo(movement: movement, maxSteps: -1),
        throwsAssertionError);

    player.xPos = 2;
    player.yPos = 0;
    expect(() => player.moveTo(movement: movement, maxSteps: 2),
        throwsAssertionError);

    player.xPos = 0;
    player.yPos = 2;
    expect(() => player.moveTo(movement: movement, maxSteps: 2),
        throwsAssertionError);
  });
}

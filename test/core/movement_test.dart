import 'package:flutter_test/flutter_test.dart';
import 'package:rpg/core/capabilities/move/movement.dart';
import 'package:rpg/core/scenario/vertex.dart';
import 'package:rpg/core/tiles/can_pass/grass.dart';
import 'package:rpg/core/tiles/impassable/wall.dart';

void main() {
  test('should create moviment if args are valid', () {
    final origin = Vertex(tile: Grass(), xPos: 0, yPos: 0);
    final destiny = Vertex(tile: Grass(), xPos: 0, yPos: 1);
    final movement = Movement.unit(
      origin: origin,
      destination: destiny,
    );
    expect(origin == movement.origin, true);
    expect(destiny == movement.destination, true);
    expect(movement.path.contains(origin), true);
    expect(movement.path.contains(destiny), true);
    expect(movement.containsInPath(x: 0, y: 0), true);
    expect(movement.containsInPath(x: 2, y: 2), false);
    expect(movement.path.length == 2, true);
    expect(movement.distance == 1, true);
  });

  test('should throw assertion error if args are invalid', () {
    final vertex = Vertex(tile: Grass(), xPos: 0, yPos: 0);
    final farVertex = Vertex(tile: Grass(), xPos: 2, yPos: 2);
    final cantPassVertex = Vertex(tile: Wall(), xPos: 0, yPos: 0);
    expect(() => Movement.unit(origin: vertex, destination: null),
        throwsAssertionError);
    expect(() => Movement.unit(origin: null, destination: vertex),
        throwsAssertionError);
    expect(() => Movement.unit(origin: cantPassVertex, destination: vertex),
        throwsAssertionError);
    expect(() => Movement.unit(origin: vertex, destination: cantPassVertex),
        throwsAssertionError);
    expect(() => Movement.unit(origin: vertex, destination: farVertex),
        throwsAssertionError);
    expect(() => Movement.unit(origin: vertex, destination: vertex),
        throwsAssertionError);
  });

  test('should move to adjacent vertex and create path', () {
    final origin = Vertex(tile: Grass(), xPos: 0, yPos: 0);
    final destiny = Vertex(tile: Grass(), xPos: 0, yPos: 1);
    var movement = Movement.unit(
      origin: origin,
      destination: destiny,
    );
    final newDestiny = Vertex(tile: Grass(), xPos: 0, yPos: 2);
    movement = movement.to(newDestiny);
    assert(movement.destination == newDestiny, true);
    assert(movement.destination != destiny, false);
    assert(movement.distance == 2, true);
    assert(movement.path.length == 3, true);
    assert(movement.path.elementAt(0) == origin, true);
    assert(movement.path.elementAt(1) == destiny, true);
    assert(movement.path.elementAt(2) == newDestiny, true);
  });

  test(
      'should throw assertion error when moving to invalid or non adjacent vertex',
      () {
    final origin = Vertex(tile: Grass(), xPos: 0, yPos: 0);
    final destiny = Vertex(tile: Grass(), xPos: 0, yPos: 1);
    final movement = Movement.unit(
      origin: origin,
      destination: destiny,
    );
    final farDestiny = Vertex(tile: Grass(), xPos: 2, yPos: 2);
    final cantPassDestiny = Vertex(tile: Wall(), xPos: 0, yPos: 2);
    expect(() => movement.to(farDestiny), throwsAssertionError);
    expect(() => movement.to(cantPassDestiny), throwsAssertionError);
    expect(() => movement.to(destiny), throwsAssertionError);
    expect(() => movement.to(origin), throwsAssertionError);
    expect(() => movement.to(null), throwsAssertionError);
  });
}

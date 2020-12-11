import 'package:flutter_test/flutter_test.dart';
import 'package:rpg/core/capabilities/move/movement.dart';
import 'package:rpg/core/maps/base/vertex.dart';
import 'package:rpg/core/tiles/can_pass/grass.dart';
import 'package:rpg/core/tiles/impassable/wall.dart';

void main() {
  test('should create moviment if args are valid', () {
    final source = Vertex(tile: Grass(), xPos: 0, yPos: 0);
    final destiny = Vertex(tile: Grass(), xPos: 0, yPos: 1);
    final movement = Movement.unit(
      source: source,
      destiny: destiny,
    );
    expect(source == movement.source, true);
    expect(destiny == movement.destiny, true);
    expect(movement.path.contains(source), true);
    expect(movement.path.contains(destiny), true);
    expect(movement.path.length == 2, true);
    expect(movement.distance == 1, true);
  });

  test('should throw assertion error if args are invalid', () {
    final vertex = Vertex(tile: Grass(), xPos: 0, yPos: 0);
    final farVertex = Vertex(tile: Grass(), xPos: 2, yPos: 2);
    final cantPassVertex = Vertex(tile: Wall(), xPos: 0, yPos: 0);
    expect(() => Movement.unit(source: vertex, destiny: null),
        throwsAssertionError);
    expect(() => Movement.unit(source: null, destiny: vertex),
        throwsAssertionError);
    expect(() => Movement.unit(source: cantPassVertex, destiny: vertex),
        throwsAssertionError);
    expect(() => Movement.unit(source: vertex, destiny: cantPassVertex),
        throwsAssertionError);
    expect(() => Movement.unit(source: vertex, destiny: farVertex),
        throwsAssertionError);
    expect(() => Movement.unit(source: vertex, destiny: vertex),
        throwsAssertionError);
  });

  test('should move to adjacent vertex and create path', () {
    final source = Vertex(tile: Grass(), xPos: 0, yPos: 0);
    final destiny = Vertex(tile: Grass(), xPos: 0, yPos: 1);
    var movement = Movement.unit(
      source: source,
      destiny: destiny,
    );
    final newDestiny = Vertex(tile: Grass(), xPos: 0, yPos: 2);
    movement = movement.to(newDestiny);
    assert(movement.destiny == newDestiny, true);
    assert(movement.destiny != destiny, false);
    assert(movement.distance == 2, true);
    assert(movement.path.length == 3, true);
    assert(movement.path.elementAt(0) == source, true);
    assert(movement.path.elementAt(1) == destiny, true);
    assert(movement.path.elementAt(2) == newDestiny, true);
  });

  test(
      'should throw assertion error when moving to invalid or non adjacent vertex',
      () {
    final source = Vertex(tile: Grass(), xPos: 0, yPos: 0);
    final destiny = Vertex(tile: Grass(), xPos: 0, yPos: 1);
    final movement = Movement.unit(
      source: source,
      destiny: destiny,
    );
    final farDestiny = Vertex(tile: Grass(), xPos: 2, yPos: 2);
    final cantPassDestiny = Vertex(tile: Wall(), xPos: 0, yPos: 2);
    expect(() => movement.to(farDestiny), throwsAssertionError);
    expect(() => movement.to(cantPassDestiny), throwsAssertionError);
    expect(() => movement.to(destiny), throwsAssertionError);
    expect(() => movement.to(source), throwsAssertionError);
    expect(() => movement.to(null), throwsAssertionError);
  });
}

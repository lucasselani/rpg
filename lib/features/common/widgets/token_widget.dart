import 'package:flutter/material.dart';
import 'package:rpg/core/characters/base/character.dart';
import 'package:rpg/core/scenario/stage.dart';

class TokenWidget extends StatelessWidget {
  final Character character;
  final Stage stage;

  const TokenWidget({Key key, this.character, this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        width: 20,
        height: 20,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: character.color,
        ),
      );
}

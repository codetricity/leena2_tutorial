import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:leena2/game/leena_game.dart';

class IntroPanel extends PositionComponent with HasGameRef<LeenaGame> {
  final String messageToLeena = 'Leena, this is your father. '
      'My ship has crashed and the crystals that power my '
      'engines are gone. I will be trapped here unless '
      'you can gather 7 crystals and bring them to me. '
      'The only vehicle that can move quickly in the gravity of '
      'this planet is the hoverboard I made for you. '
      'My oxygen is running low.  I hope I see you again.';
  @override
  Future<void>? onLoad() {
    var father = SpriteComponent(
        sprite: gameRef.fatherSprite,
        size: Vector2(gameRef.size[1] - 100, gameRef.size[1] - 100),
        position: Vector2(gameRef.size[0] / 2 + 50, 50));
    add(father);
    add(IntroMessage(messageToLeena, gameRef.size[0] / 2 - 50)
      ..size = Vector2(400, gameRef.size[1] - 100));

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawColor(Colors.pink, BlendMode.src);
  }
}

class IntroMessage extends TextBoxComponent {
  IntroMessage(String text, double width)
      : super(
            text: text,
            boxConfig: TextBoxConfig(maxWidth: width, timePerChar: 0.05));
  @override
  void drawBackground(Canvas c) {
    Rect rect = Rect.fromLTWH(0, 0, width, height);
    c.drawRect(rect, Paint()..color = Colors.red);
  }
}

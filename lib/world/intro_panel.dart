import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:leena2/game/leena_game.dart';

class IntroPanel extends PositionComponent with HasGameRef<LeenaGame> {
  @override
  Future<void>? onLoad() {
    var father = SpriteComponent(
        sprite: gameRef.fatherSprite,
        size: Vector2(gameRef.size[1] - 100, gameRef.size[1] - 100),
        position: Vector2(gameRef.size[0] / 2 + 50, 50));
    add(father);

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawColor(Colors.pink, BlendMode.src);
  }
}

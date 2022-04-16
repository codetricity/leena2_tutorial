import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:leena2/main.dart';
import 'package:leena2/world/ground.dart';

// new in Flame 1.1 (April 2022)
class Leena extends SpriteComponent
    with CollisionCallbacks, HasGameRef<LeenaGame> {
  Leena() : super() {
    debugMode = true;
  }

  bool onGround = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void onCollision(intersectionPoints, other) {
    super.onCollision(intersectionPoints, other);

    if (other is Ground) {
      gameRef.velocity.y = 0;
      print('hit ground');
      onGround = true;
    }
  }
}

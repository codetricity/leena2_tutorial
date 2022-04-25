import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:leena2/actors/leena.dart';
import 'package:tiled/tiled.dart';

class Gem extends SpriteComponent with CollisionCallbacks {
  final TiledObject tiledObject;
  Gem({required this.tiledObject}) : super() {
    debugMode = true;
  }

  @override
  Future<void>? onLoad() async {
    add(RectangleHitbox());
    print(tiledObject.type);
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    print('hit gem');
    if (other is Leena) {
      removeFromParent();
    }

    super.onCollision(intersectionPoints, other);
  }
}

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tiled/tiled.dart';

class Gem extends SpriteComponent with CollisionCallbacks {
  final TiledObject tiledObject;
  Gem({required this.tiledObject});

  @override
  Future<void>? onLoad() async {
    add(RectangleHitbox());
    print(tiledObject.type);
    return super.onLoad();
  }
}

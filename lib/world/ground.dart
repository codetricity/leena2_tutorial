import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Ground extends PositionComponent {
  Ground({required size, required position})
      : super(size: size, position: position) {
    debugMode = true;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // new in Flame 1.1 - collision changed
    add(RectangleHitbox());
  }
}

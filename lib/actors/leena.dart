import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:leena2/main.dart';
import 'package:leena2/world/ground.dart';

// new in Flame 1.1 (April 2022)
class Leena extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<LeenaGame> {
  Leena() : super() {
    debugMode = true;
    anchor = Anchor.bottomCenter;
  }

  bool onGround = false;
  bool facingRight = true;
  bool hitRight = false;
  bool hitLeft = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // moving left
    if (x > 0 && gameRef.velocity.x <= 0) {
      gameRef.velocity.x += gameRef.groundFriction;

      if (gameRef.velocity.x > 0) {
        gameRef.velocity.x = 0;
      }
    } else if (x < gameRef.mapWidth - width && gameRef.velocity.x >= 0) {
      // moving to the right
      gameRef.velocity.x -= gameRef.groundFriction;
      // print('${gameRef.velocity.x}, ${gameRef.groundFriction}');
      if (gameRef.velocity.x < 0) {
        gameRef.velocity.x = 0;
      }
    } else {
      gameRef.velocity.x = 0;
    }

    if (gameRef.velocity.x == 0 && !onGround) {
      animation = gameRef.idleAnim;
    }
  }

  @override
  void onCollision(intersectionPoints, other) {
    super.onCollision(intersectionPoints, other);
    if (other is Ground) {
      if (gameRef.velocity.y > 0) {
        if (intersectionPoints.length == 2) {
          var x1 = intersectionPoints.first[0];
          var x2 = intersectionPoints.last[0];
          if ((x1 - x2).abs() < 10) {
            // hit the side, so send down with gravity.
            gameRef.velocity.y = 100;
            print('stuck on side');
          } else {
            // hit ground
            gameRef.velocity.y = 0;
            onGround = true;
          }
        }
      }
      if (gameRef.velocity.x != 0) {
        for (var point in intersectionPoints) {
          if (y - 5 >= point[1]) {
            print('hit on side of ground');
            print('the bottom of the girl is $y');
            print('one of the y intersection points is ${point[1]}');
            print('note that ${point[1]} is much higher than $y}');
            gameRef.velocity.x = 0;
            if (point[0] > x) {
              // print('hit right');
              hitRight = true;
              hitLeft = false;
            } else {
              // print('hit left');
              hitLeft = true;
              hitRight = false;
            }
          }
        }
      }
    }
  }

  @override
  void onCollisionEnd(other) {
    super.onCollisionEnd(other);
    onGround = false;
    hitLeft = false;
    hitRight = false;
  }
}

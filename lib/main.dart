import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:leena2/actors/leena.dart';
import 'package:leena2/world/ground.dart';
import 'package:tiled/tiled.dart';

void main() {
  runApp(GameWidget(game: LeenaGame()));
}

class LeenaGame extends FlameGame with HasCollisionDetection, TapDetector {
  Leena leena = Leena();
  final double gravity = 2.8;
  final double pushSpeed = 80;
  final double groundFriction = .32;
  final double jumpForce = 180;
  Vector2 velocity = Vector2(0, 0);
  late TiledComponent homeMap;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    homeMap = await TiledComponent.load('map.tmx', Vector2.all(32));
    add(homeMap);

    double mapWidth = 32.0 * homeMap.tileMap.map.width;
    double mapHeight = 32.0 * homeMap.tileMap.map.height;
    // recent change in flame_tiled..  v 1.4?
    var obstacleGroup = homeMap.tileMap.getLayer<ObjectGroup>('ground');

    for (final obj in obstacleGroup!.objects) {
      add(Ground(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y)));
    }

    camera.viewport = FixedResolutionViewport(Vector2(mapWidth, mapHeight));

    leena
      ..sprite = await loadSprite('girl.png')
      ..size = Vector2.all(100)
      ..position = Vector2(440, 30);
    add(leena);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!leena.onGround) {
      velocity.y += gravity;
    }
    leena.position += velocity * dt;
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    if (leena.onGround) {
      if (info.eventPosition.game.x < 100) {
        print('push left');
        if (leena.facingRight) {
          leena.flipHorizontallyAroundCenter();
          leena.facingRight = false;
        }
        if (!leena.hitLeft) {
          leena.x -= 5;
          velocity.x -= pushSpeed;
        }
      } else if (info.eventPosition.game.x > size[0] - 100) {
        print('push right');
        if (!leena.facingRight) {
          leena.facingRight = true;
          leena.flipHorizontallyAroundCenter();
        }
        if (!leena.hitRight) {
          leena.x += 5;
          velocity.x += pushSpeed;
        }
      }
      if (info.eventPosition.game.y < 100) {
        print('jump up');

        leena.y -= 10;
        velocity.y = -jumpForce;
      }
    }
  }
}

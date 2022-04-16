import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:leena2/actors/leena.dart';
import 'package:leena2/world/ground.dart';
import 'package:tiled/tiled.dart';

void main() {
  runApp(GameWidget(game: LeenaGame()));
}

class LeenaGame extends FlameGame with HasCollisionDetection {
  Leena leena = Leena();
  double gravity = 1.8;
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
      ..position = Vector2(340, 30);
    add(leena);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!leena.onGround) {
      velocity.y += gravity;
      leena.position.y += velocity.y * dt;
    }
  }
}

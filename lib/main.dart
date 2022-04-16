import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: LeenaGame()));
}

class LeenaGame extends FlameGame {
  SpriteComponent leena = SpriteComponent();
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

    camera.viewport = FixedResolutionViewport(Vector2(mapWidth, mapHeight));

    leena
      ..sprite = await loadSprite('girl.png')
      ..size = Vector2.all(100)
      ..position = Vector2(100, 30);
    add(leena);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (leena.y < size[1] - leena.height) {
      velocity.y += gravity;
      leena.position.y += velocity.y * dt;
    }
  }
}

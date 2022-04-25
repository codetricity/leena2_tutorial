import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:leena2/actors/leena.dart';
import 'package:leena2/world/ground.dart';
import 'package:tiled/tiled.dart';

import 'actors/gem.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(GameWidget(game: LeenaGame()));
}

class LeenaGame extends FlameGame with HasCollisionDetection, TapDetector {
  Leena leena = Leena();
  final double gravity = 2.8;
  final double pushSpeed = 80;
  final double groundFriction = .52;
  final double jumpForce = 180;
  Vector2 velocity = Vector2(0, 0);
  late TiledComponent homeMap;
  late SpriteAnimation rideAnim;
  late SpriteAnimation pushAnim;
  late SpriteAnimation idleAnim;
  late SpriteAnimation jumpAnim;
  late double mapWidth;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    homeMap = await TiledComponent.load('map2.tmx', Vector2.all(32));
    add(homeMap);

    mapWidth = 32.0 * homeMap.tileMap.map.width;
    double mapHeight = 32.0 * homeMap.tileMap.map.height;
    // recent change in flame_tiled..  v 1.4?
    var obstacleGroup = homeMap.tileMap.getLayer<ObjectGroup>('ground');

    for (final obj in obstacleGroup!.objects) {
      add(Ground(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y)));
    }

    var gemGroup = homeMap.tileMap.getLayer<ObjectGroup>('gems');

    for (final gem in gemGroup!.objects) {
      add(Gem(tiledObject: gem)
        ..sprite = await loadSprite('gems/Ruby.png')
        ..position = Vector2(gem.x, gem.y - gem.height)
        ..size = Vector2(gem.width, gem.height));
    }

    // camera.viewport = FixedResolutionViewport(Vector2(mapWidth, mapHeight));
    camera.viewport = FixedResolutionViewport(Vector2(1280, mapHeight));

    rideAnim = SpriteAnimation.spriteList(
        await fromJSONAtlas('ride.png', 'ride.json'),
        stepTime: 0.1);
    pushAnim = SpriteAnimation.spriteList(
        await fromJSONAtlas('push.png', 'push.json'),
        stepTime: 0.1);
    idleAnim = SpriteAnimation.spriteList(
        await fromJSONAtlas('idle.png', 'idle.json'),
        stepTime: 0.1);
    jumpAnim = SpriteAnimation.spriteList(
        await fromJSONAtlas('jump.png', 'jump.json'),
        stepTime: 0.1);

    leena
      ..animation = rideAnim
      ..size = Vector2(83, 100)
      ..position = Vector2(440, 30);
    add(leena);
    camera.followComponent(leena,
        worldBounds: Rect.fromLTRB(0, 0, mapWidth, mapHeight));
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
      if (info.eventPosition.viewport.x < 100) {
        print('push left');
        if (leena.facingRight) {
          leena.flipHorizontallyAroundCenter();
          leena.facingRight = false;
        }
        if (!leena.hitLeft) {
          leena.x -= 5;
          velocity.x -= pushSpeed;
          leena.animation = pushAnim;
          Future.delayed(const Duration(milliseconds: 1200), () {
            leena.animation = rideAnim;
          });
        }
      } else if (info.eventPosition.viewport.x > size[0] - 100) {
        print('push right');
        if (!leena.facingRight) {
          leena.facingRight = true;
          leena.flipHorizontallyAroundCenter();
        }
        if (!leena.hitRight) {
          leena.x += 5;
          velocity.x += pushSpeed;
          leena.animation = pushAnim;
          Future.delayed(const Duration(milliseconds: 1200), () {
            leena.animation = rideAnim;
          });
        }
      }
      if (info.eventPosition.game.y < 100) {
        print('jump up');
        leena.animation = jumpAnim;
        Future.delayed(const Duration(milliseconds: 1200), () {
          leena.animation = rideAnim;
        });
        leena.y -= 10;
        velocity.y = -jumpForce;
        leena.onGround = false;
      }
    }
  }
}

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:leena2/actors/leena.dart';
import 'package:leena2/world/ground.dart';
import 'package:tiled/tiled.dart';

import 'actors/gem.dart';
import 'dashboard/dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GameWidget(
          game: LeenaGame(),
          overlayBuilderMap: {
            'DashboardOverlay': (BuildContext context, LeenaGame game) {
              return Dashboard(
                game: game,
              );
            }
          },
        ),
      ),
    ),
  );
}

class LeenaGame extends FlameGame with HasCollisionDetection, TapDetector {
  Leena leena = Leena(position: Vector2(340, 30));
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
  late AudioPool yay;
  late AudioPool bonus;

  int magicLevel = 0;

  late Timer countDown;
  int remainingTime = 30;
  bool timerStarted = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    countDown = Timer(1, onTick: () {
      if (remainingTime > 0) {
        remainingTime -= 1;
        print('notified listener');

        overlays.notifyListeners();
      }
    }, repeat: true);

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
      var gemSprite = await loadSprite('gems/${gem.type}.png');
      add(Gem(tiledObject: gem)
        ..sprite = gemSprite
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

    leena..animation = rideAnim;
    add(leena);
    camera.followComponent(leena,
        worldBounds: Rect.fromLTRB(0, 0, mapWidth, mapHeight));
    // load audio file from local storage into game
    yay = await AudioPool.create('yay.mp3');
    bonus = await AudioPool.create('bonus.wav');
    overlays.add('DashboardOverlay');
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!leena.onGround) {
      velocity.y += gravity;
    }
    leena.position += velocity * dt;

    if (timerStarted && remainingTime > 0) {
      countDown.update(dt);
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    if (leena.onGround) {
      if (info.eventPosition.viewport.x < 100) {
        timerStarted = true;
        print('push left');
        if (leena.facingRight) {
          leena.flipHorizontallyAroundCenter();
          leena.facingRight = false;
        }
        if (!leena.hitLeft && remainingTime > 0) {
          leena.x -= 15;
          velocity.x -= pushSpeed;
          leena.animation = pushAnim;
          Future.delayed(const Duration(milliseconds: 1200), () {
            if (leena.animation != jumpAnim) {
              leena.animation = rideAnim;
            }
          });
        }
      } else if (info.eventPosition.viewport.x > size[0] - 100) {
        timerStarted = true;
        print('push right');
        if (!leena.facingRight) {
          leena.facingRight = true;
          leena.flipHorizontallyAroundCenter();
        }
        if (!leena.hitRight && remainingTime > 0) {
          leena.x += 15;
          velocity.x += pushSpeed;
          leena.animation = pushAnim;
          Future.delayed(const Duration(milliseconds: 1200), () {
            if (leena.animation != jumpAnim) {
              leena.animation = rideAnim;
            }
          });
        }
      }
      if (info.eventPosition.game.y < 100) {
        print('jump up');
        leena.animation = jumpAnim;
        Future.delayed(const Duration(milliseconds: 1200), () {
          leena.animation = rideAnim;
        });
        if (remainingTime > 0) {
          leena.y -= 10;
          velocity.y = -jumpForce;
          leena.onGround = false;
        }
      }
    }
  }
}

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dashboard/dashboard.dart';
import 'game/leena_game.dart';

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

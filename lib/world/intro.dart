import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Intro extends PositionComponent with HasGameRef<LeenaGame> {
  Intro({required size}) : super(size: size);

  @override
  void render(Canvas canvas) {
    canvas.drawColor(Colors.blueGrey, BlendMode.src);
  }
}

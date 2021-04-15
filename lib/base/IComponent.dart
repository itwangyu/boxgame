import 'dart:ui';

import 'package:boxgame/BoxGame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

abstract class IComponent{
  BoxGame game;
  Rect rect;
  Sprite sprite;


  IComponent(this.game);

  void render(Canvas canvas);

  void update(double t);

  void onTapDown(TapDownDetails details) {}
  void onTapUp(TapUpDetails details) {}
}
import 'dart:ui';

import 'package:boxgame/BoxGame.dart';
import 'package:boxgame/PageState.dart';
import 'package:boxgame/base/IComponent.dart';
import 'package:flame/gestures.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

class StartButton extends IComponent {
  StartButton(BoxGame game) : super(game) {
    ///720*360   6:3
    double width = game.tileSize * 6;
    double height = game.tileSize * 3;
    rect = Rect.fromLTWH(
        (game.mScreenSize.width - width) / 2,
        (game.mScreenSize.height - height) / 2 + game.tileSize * 5,
        width,
        height);
    sprite = Sprite("ui/start-button.png");
  }

  @override
  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }

  @override
  void update(double t) {}

  @override
  void onTapDown(TapDownDetails details) {
    game.currentPageState = PageState.PLAY;
  }
}

import 'dart:ui';

import 'package:boxgame/BoxGame.dart';
import 'package:boxgame/base/IComponent.dart';
import 'package:flame/sprite.dart';

class HomeView extends IComponent {

  HomeView(game):super(game) {
    /// 1080/9=120
    /// 标题图片的尺寸是 840 * 480  所以他是 7 * 4
    rect = Rect.fromLTWH(
        (game.mScreenSize.width - game.tileSize * 7) / 2,
        (game.mScreenSize.height - game.tileSize * 4) / 2 - game.tileSize*2,
        game.tileSize * 7,
        game.tileSize * 4);
    sprite = Sprite("branding/title.png");
  }

  @override
  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }

  @override
  void update(double t) {}
}

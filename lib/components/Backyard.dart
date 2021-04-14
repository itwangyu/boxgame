import 'dart:ui';

import 'package:boxgame/BoxGame.dart';
import 'package:flame/sprite.dart';

class Backyard {
  BoxGame game;
  Sprite sprite;
  Rect rect;

  Backyard(this.game) {
    ///这个背景图片是1080*2760的，它是要铺满屏幕宽度的，所以它的宽度也是9个单位
    ///1080 / 9 = 120 （每个单位的像素是120px）
    ///2760 / 120 = 23  图片高度是23个单位
    ///注意在不同尺寸屏幕上一个单位代表的像素是不同的，所以图片一定要用9:23表示
    ///通过这个计算来保证背景图片铺满屏幕宽度的情况下保证宽高比
    sprite = Sprite("bg/backyard.png");

    ///画背景图片的时候根据计算的宽高比铺满，注意top是负值，背景图片是底边与屏幕对其，
    ///所以顶部负值就是屏幕显示不下的部分：屏幕高度-23个单位
    rect = Rect.fromLTWH(
        0,
        game.mScreenSize.height - game.tileSize * 23, //注意图片高度必须这么表示才不会变形
        game.tileSize * 9, //宽度是9个单位
        game.tileSize * 23); //高度是23个单位
  }

  void render(Canvas canvas) {
    sprite.renderRect(canvas,rect);
  }

  void update(double t) {

  }


}

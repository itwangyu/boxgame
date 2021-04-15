import 'package:boxgame/BoxGame.dart';
import 'package:boxgame/base/IComponent.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';

class Fly extends IComponent {
  double _x, _y;
  Rect rect;
  bool isDead = false;
  bool isOutScreen = false;
  List<Sprite> flyingSprite = [];
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  double zoom = 1;
  Offset targetLocation;

  Fly(game, this._x, this._y, this.zoom) : super(game) {
    rect = Rect.fromLTWH(_x, _y, game.tileSize * zoom, game.tileSize * zoom);
    setTargetLocation();
  }

  @override
  void render(Canvas canvas) {
    if (isDead) {
      deadSprite.renderRect(canvas, rect.inflate(2));
    } else {
      // print("picIndex:${flyingSpriteIndex.toInt() % 2}");
      flyingSprite[flyingSpriteIndex.toInt() % 2]
          .renderRect(canvas, rect.inflate(2));
    }
  }

  double get speed => game.tileSize * 3;

  @override
  void update(double t) {
    if (isDead) {
      //苍蝇死掉了，位置向下平移
      rect = rect.translate(0, game.tileSize * 12 * t);
    } else {
      flyingSpriteIndex += 30 * t;
      if (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }
      //速度*时间=苍蝇每帧需要移动的距离
      double distance = speed * t;
      //用目标位置-当前位置=距离目标的偏移量
      Offset distanceOffset = targetLocation - Offset(rect.left, rect.top);
      //判断苍蝇需要移动的距离是否小于距离目标的距离
      if (distance < distanceOffset.distance) {
        //苍蝇距离目标位置还远，至少是超过每帧要移动的距离，这种情况
        //我们需要修正苍蝇的位置，使苍蝇向目标方向移动distance的距离
        rect = rect
            .shift(Offset.fromDirection(distanceOffset.direction, distance));
      } else {
        //这种情况苍蝇距离目标位置已经小于一个单位移动距离了，我们直接把苍蝇的下个位置设置为目标位置即可
        rect = rect.shift(distanceOffset);
        //然后设定新的目标位置
        setTargetLocation();
      }
    }
    //判断苍蝇下落是否超出屏幕
    if (rect.top >= game.mScreenSize.height) {
      isOutScreen = true;
    }
  }

  ///设定苍蝇的目标位置
  ///初始的时候设定一次，等苍蝇飞到当前的目标位置之后再设定一次生成一个新的位置
  void setTargetLocation() {
    double x = game.mRandom.nextDouble() *
        (game.mScreenSize.width - (game.tileSize * 2.025));
    double y = game.mRandom.nextDouble() *
        (game.mScreenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }

  @override
  void onTapDown(TapDownDetails details) {
    isDead = true;
  }
}

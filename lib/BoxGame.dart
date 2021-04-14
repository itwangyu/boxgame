import 'dart:math';
import 'dart:ui';

import 'package:boxgame/components/AgileFly.dart';
import 'package:boxgame/components/DroolerFly.dart';
import 'package:boxgame/components/HouseFly.dart';
import 'package:boxgame/components/HungryFly.dart';
import 'package:boxgame/components/MachoFly.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';

import 'components/Backyard.dart';
import 'components/Fly.dart';

class BoxGame extends Game with TapDetector {
  Random mRandom = Random();

  //屏幕尺寸
  Size mScreenSize;

  //一个苍蝇的尺寸，也是单位宽度，以后的尺寸计算都基于这个单位。无论屏幕多宽，都能并排放置9个苍蝇
  double tileSize;

  //苍蝇的集合
  List<Fly> flyList = [];

  Backyard backyard;

  BoxGame() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    backyard = Backyard(this);

    spawnFly();
  }

  ///生产飞蝇
  void spawnFly() {
    double x = mRandom.nextDouble() * (mScreenSize.width - tileSize * 2.025);
    double y = mRandom.nextDouble() * (mScreenSize.height - tileSize * 2.025);
    switch (mRandom.nextInt(5)) {
      case 0:
        flyList.add(HouseFly(this, x, y));
        break;
      case 1:
        flyList.add(DroolerFly(this, x, y));
        break;
      case 2:
        flyList.add(AgileFly(this, x, y));
        break;
      case 3:
        flyList.add(MachoFly(this, x, y));
        break;
      case 4:
        flyList.add(HungryFly(this, x, y));
        break;
    }
  }

  @override
  void resize(Size size) {
    super.resize(size);
    mScreenSize = size;
    //设定的单位尺寸是宽度的九分之一，也就是将屏幕宽度分为九个区块
    tileSize = mScreenSize.width / 9;
  }

  @override
  void render(Canvas canvas) {
    if (backyard == null) {
      return;
    }
    backyard.render(canvas);
    //画苍蝇
    flyList.forEach((Fly fly) {
      fly.render(canvas);
    });
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    bool touch = false;
    flyList.forEach((fly) {
      if (fly.rect.contains(details.globalPosition) && !fly.isDead) {
        fly.onTapDown();
        touch = true;
      }
    });
    if (touch) {
      spawnFly();
    }
  }

  @override
  void update(double t) {
    // print("update:$t");
    flyList.forEach((Fly fly) {
      fly.update(t);
    });
    flyList.removeWhere((element) => element.isOutScreen);
  }
}

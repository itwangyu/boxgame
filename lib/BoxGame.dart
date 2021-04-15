import 'dart:math';
import 'dart:ui';

import 'package:boxgame/PageState.dart';
import 'package:boxgame/components/AgileFly.dart';
import 'package:boxgame/components/DroolerFly.dart';
import 'package:boxgame/components/HouseFly.dart';
import 'package:boxgame/components/HungryFly.dart';
import 'package:boxgame/components/MachoFly.dart';
import 'package:boxgame/components/StartButton.dart';
import 'package:boxgame/views/HomeView.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';

import 'components/Backyard.dart';
import 'components/Fly.dart';

class BoxGame extends Game {
  Random mRandom = Random();

  //屏幕尺寸
  Size mScreenSize;

  //一个苍蝇的尺寸，也是单位宽度，以后的尺寸计算都基于这个单位。无论屏幕多宽，都能并排放置9个苍蝇
  double tileSize;

  //苍蝇的集合
  List<Fly> flyList = [];

  ///背景组件
  Backyard backyard;

  ///记录当前的页面状态
  PageState currentPageState = PageState.PLAY;

  //标题view
  HomeView homeView;

  //开始按钮
  StartButton startButton;

  BoxGame() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    backyard = Backyard(this);
    homeView = HomeView(this);
    startButton = StartButton(this);
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
    //画背景
    backyard.render(canvas);
    //画苍蝇
    flyList.forEach((Fly fly) {
      fly.render(canvas);
    });

    switch (currentPageState) {
      case PageState.HOME:
        //画标题
        homeView.render(canvas);
        //开始按钮
        startButton.render(canvas);
        break;
      case PageState.PLAY:
        break;
      case PageState.LOSE:
        startButton.render(canvas);
        break;
    }
  }

  @override
  void onTapDown(TapDownDetails details) {
    // super.onTapDown(details);
    //按照渲染的组件倒序分发点击事件 这个变量标记点击事件是否被处理
    bool handle = false;
    //记录用户是否点击到了苍蝇
    bool touch = false;

    // if (!handle &&
    //     startButton.rect.contains(details.globalPosition) &&
    //     (currentPageState == PageState.HOME ||
    //         currentPageState == PageState.LOSE)) {
    //   handle = true;
    //   startButton.onTapDown(details);
    // }
    //
    // if (!handle) {
    //   flyList.forEach((fly) {
    //     if (fly.rect.contains(details.globalPosition) && !fly.isDead) {
    //       fly.onTapDown(details);
    //       touch = true;
    //       handle = true;
    //     }
    //   });
    // }
    //
    // if (touch) {
    //   spawnFly();
    // }
  }

  @override
  void update(double t) {
    // print("update:$t");
    flyList.forEach((Fly fly) {
      fly.update(t);
    });
    // flyList.removeWhere((element) => element.isOutScreen);
  }
}

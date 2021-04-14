import 'package:boxgame/BoxGame.dart';
import 'package:flame/sprite.dart';

import 'Fly.dart';

class DroolerFly extends Fly {
  DroolerFly(BoxGame game, double x, double y) : super(game, x, y, 1.5) {
    flyingSprite.add(Sprite('flies/drooler-fly-1.png'));
    flyingSprite.add(Sprite('flies/drooler-fly-2.png'));
    deadSprite = Sprite('flies/drooler-fly-dead.png');
  }

  double get speed => game.tileSize * 1.5;
}

import 'package:boxgame/BoxGame.dart';
import 'package:boxgame/components/Fly.dart';
import 'package:flame/sprite.dart';

class AgileFly extends Fly {
  AgileFly(BoxGame game, double x, double y) : super(game, x, y,1.5) {
    flyingSprite.add(Sprite('flies/agile-fly-1.png'));
    flyingSprite.add(Sprite('flies/agile-fly-2.png'));
    deadSprite = Sprite('flies/agile-fly-dead.png');
  }

  double get speed => game.tileSize * 5;
}
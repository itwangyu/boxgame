import 'package:boxgame/BoxGame.dart';
import 'package:boxgame/components/Fly.dart';
import 'package:flame/sprite.dart';

class HungryFly extends Fly {
  HungryFly(BoxGame game, double x, double y) : super(game, x, y, 1.65) {
    flyingSprite.add(Sprite('flies/hungry-fly-1.png'));
    flyingSprite.add(Sprite('flies/hungry-fly-2.png'));
    deadSprite = Sprite('flies/hungry-fly-dead.png');
  }
}

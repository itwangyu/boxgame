import 'package:boxgame/BoxGame.dart';
import 'package:boxgame/components/Fly.dart';
import 'package:flame/sprite.dart';

class HouseFly extends Fly {
  HouseFly(BoxGame game, double x, double y) : super(game, x, y, 1.5) {
    flyingSprite.add(Sprite("flies/house-fly-1.png"));
    flyingSprite.add(Sprite("flies/house-fly-2.png"));
    deadSprite = Sprite("flies/house-fly-dead.png");
  }
}

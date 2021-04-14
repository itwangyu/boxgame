import 'package:boxgame/BoxGame.dart';
import 'package:boxgame/components/Fly.dart';
import 'package:flame/sprite.dart';

class MachoFly extends Fly {

  MachoFly(BoxGame game, double x, double y) : super(game, x, y, 2.025) {
    flyingSprite.add(Sprite('flies/macho-fly-1.png'));
    flyingSprite.add(Sprite('flies/macho-fly-2.png'));
    deadSprite = Sprite('flies/macho-fly-dead.png');
  }

  double get speed => game.tileSize * 2.5;
}

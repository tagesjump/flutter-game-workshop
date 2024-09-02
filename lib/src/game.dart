import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:v2/src/game_assets.dart';

class MyGame extends Forge2DGame with KeyboardEvents {
  MyGame() : super(gravity: Vector2(0.0, 200.0));

  late GameSprites sprites;

  static const _worldScale = .5;

  @override
  Future<void> onLoad() async {
    sprites = GameSprites(this);
    await sprites.onLoad();

    await super.onLoad();

    camera.viewport.add(FpsTextComponent());

    // TODO: initialize mapComponent
    // deskTileSize = 18.0
    // fileName = level1.tmx
    // prefix = assets/maps/

    // TODO: ground my border
    // TODO: map layer components
  }

  void gameOver() {
    // TODO: game over :(
  }

  void win() {
    // TODO: win! change level
  }
}

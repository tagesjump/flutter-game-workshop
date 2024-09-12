import 'package:flame/components.dart';
import 'package:v2/src/bodies/base_body.dart';

/// Батут - при контакте с игроком толкает его вверх
/// Подключенный миксин ContactCallbacks позволяет отслеживать контакты с другими телами в мире
class Jumper extends BaseBody {
  Jumper({required super.position, required this.size})
      : super(
          size: size,
          isSensor: true,
        );

  final Vector2 size;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(
      SpriteAnimationComponent(
        animation: SpriteAnimation.spriteList(
          [
            game.sprites.getTileMapSprite(7, 5),
            game.sprites.getTileMapSprite(8, 5),
          ],
          stepTime: .25,
        ),
        size: size,
      ),
    );
  }
}

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:v2/src/bodies/base_body.dart';
import 'package:v2/src/player.dart';

/// Батут - при контакте с игроком толкает его вверх
/// Подключенный миксин ContactCallbacks позволяет отслеживать контакты с другими телами в мире
class Jumper extends BaseBody with ContactCallbacks {
  Jumper({required super.position, required this.size})
      : super(
          size: size,
          isSensor: true,
        );

  final Vector2 size;

  static const _maxJumpSpeed = 140.0;

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

  @override
  void beginContact(Object other, Contact contact) {
    // Jumper - толкает игрока вверх
    if (other is Player) {
      final yVelocityChange = -_maxJumpSpeed - other.body.linearVelocity.y;
      final yImpulse = other.body.mass * yVelocityChange;
      other.body.applyLinearImpulse(Vector2(0.0, yImpulse));
    }
  }
}

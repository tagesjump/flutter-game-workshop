import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:v2/src/bodies/base_body.dart';

/// Игрок
class Player extends BaseBody {
  Player({required super.position, required this.size, super.radius})
      : super(
          // Не позволяем телу "крутиться" фиксируя его угол
          fixedRotation: true,
          // Динамическое тело обладает массой
          bodyType: BodyType.dynamic,
        );

  final Vector2 size;

  late final Component _sprite;

  /// Ограничение максимальной горизонтальной скорости
  static const _maxXSpeed = 50.0;

  /// Ограничение максимальной скорости прыжка
  static const _maxJumpSpeed = 100.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _sprite = SpriteAnimationComponent(
      animation: SpriteAnimation.spriteList(
        [
          Sprite(await game.images.load('player/player1.png')),
          Sprite(await game.images.load('player/player2.png')),
        ],
        stepTime: .25,
      ),
      size: size,
    );

    add(_sprite);

    game.camera.follow(this);
  }

  void moveUp() {
    final yImpulse = body.mass * -_maxJumpSpeed;
    body.applyLinearImpulse(Vector2(0.0, yImpulse));
  }

  void moveRight() {
    final xVelocityChange = _maxXSpeed - body.linearVelocity.x;
    final xImpulse = body.mass * xVelocityChange;
    body.applyLinearImpulse(Vector2(xImpulse, 0.0));
  }

  void moveLeft() {
    final xVelocityChange = -_maxXSpeed - body.linearVelocity.x;
    final xImpulse = body.mass * xVelocityChange;
    body.applyLinearImpulse(Vector2(xImpulse, 0.0));
  }

  void moveXStop() {
    final xImpulse = -body.linearVelocity.x * body.mass;
    body.applyLinearImpulse(Vector2(xImpulse, 0.0));
  }
}

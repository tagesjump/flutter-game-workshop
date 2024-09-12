import 'package:flame/components.dart';
import 'package:v2/src/bodies/base_body.dart';

/// Игрок
class Player extends BaseBody {
  Player({required super.position, required this.size, super.radius});

  final Vector2 size;

  late final Component _sprite;

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
}

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:v2/src/bodies/base_body.dart';

/// Флаг - игрок при взаимодействии с компонентов выигрывает
class Flag extends BaseBody {
  Flag({required super.position, required this.size})
      : super(
          size: size,
          bodyType: BodyType.kinematic,
        );

  final Vector2 size;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    addAll(
      [
        SpriteAnimationComponent(
          animation: SpriteAnimation.spriteList(
            [
              game.sprites.getTileMapSprite(11, 5),
              game.sprites.getTileMapSprite(12, 5),
            ],
            stepTime: .25,
          ),
          size: Vector2.all(size.x),
        ),
        SpriteComponent(
          sprite: game.sprites.getTileMapSprite(11, 6),
          size: Vector2.all(size.x),
          position: Vector2(0.0, size.x),
        ),
      ],
    );
  }
}

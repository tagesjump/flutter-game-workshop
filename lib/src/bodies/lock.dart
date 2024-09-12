import 'package:flame/components.dart';
import 'package:v2/src/bodies/base_body.dart';

/// Замок - компонент "открывается", игрок при наличии ключа может "открыть"
class Lock extends BaseBody {
  Lock({required super.position, required this.size}) : super(size: size);

  final Vector2 size;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    addAll(List.generate((size.y / size.x).ceil(), (i) {
      return SpriteComponent(
        sprite: game.sprites.getTileMapSprite(8, 1),
        size: Vector2.all(size.x),
        position: Vector2(0.0, i * size.x),
      );
    }));
  }
}

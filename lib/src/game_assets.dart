import 'package:flame/components.dart';
import 'package:v2/src/game.dart';

/// Вспомогательный класс для создания спрайтов.
class GameSprites {
  GameSprites(this.game);

  final MyGame game;

  Future<void> onLoad() async {
    await game.images.load(tileMapSrc);
  }

  static const tileMapSize = 18.0;
  static const tileMapSrc = 'tilemap.png';

  /// Возвращает спрайт по координатам с учетом размера тайла.
  Sprite getTileMapSprite(int x, int y) {
    return Sprite(
      game.images.fromCache(tileMapSrc),
      srcPosition: Vector2(x.toDouble(), y.toDouble()).scaled(tileMapSize),
      srcSize: Vector2.all(tileMapSize),
    );
  }
}

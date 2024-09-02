import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:v2/src/game.dart';

/// Родительский класс body компонента.
/// Формирует нужный body по размеру и/или полигону.
/// Все объекты на карте наследуются от этого класса
abstract class BaseBody extends BodyComponent<MyGame> {
  BaseBody({
    required Vector2 position,
    Vector2? size,
    List<Vector2>? polygon,
    double? radius,
    bool isSensor = false,
    BodyType bodyType = BodyType.static,
    bool fixedRotation = false,
  })  : assert(size != null || polygon != null || radius != null),
        super(
          bodyDef: BodyDef(position: position, type: bodyType),
          fixtureDefs: [
            if (size != null)
              FixtureDef(PolygonShape()..setAsBox(size.x / 2, size.y / 2, size / 2, 0.0), isSensor: isSensor),
            if (polygon != null) FixtureDef(ChainShape()..createLoop(polygon), isSensor: isSensor),
            if (radius != null) FixtureDef(CircleShape(radius: radius, position: Vector2.all(radius)))
          ],
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    /// Отключаем рендер body
    renderBody = false;

    /// Включаем возможность контакта для body.
    body.userData = this;
  }
}

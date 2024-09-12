import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:v2/src/bodies/base_body.dart';

/// По дизайну мы определили два предмета
/// - diamond - бриллиант
/// - key - ключ, необходимый для открытия "дверей"
enum ItemType {
  diamond,
  key;

  factory ItemType.fromString(String name) => ItemType.values.firstWhere((v) => v.name == name);
}

/// Компонент предмета
/// При взаимодействии с предметом игрок может его "подобрать", он сохранится у него в инвентаре
class Item extends BaseBody {
  Item({required super.position, required this.size, required this.type})
      : super(
          size: size,
          bodyType: BodyType.kinematic,
        );

  final Vector2 size;
  final ItemType type;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(SpriteComponent(
      sprite: switch (type) {
        ItemType.diamond => game.sprites.getTileMapSprite(7, 3),
        ItemType.key => game.sprites.getTileMapSprite(7, 1),
      },
      size: size,
    ));
  }
}

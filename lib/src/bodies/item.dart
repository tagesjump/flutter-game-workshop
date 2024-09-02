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
// TODO: class Item

import 'package:v2/src/bodies/base_body.dart';

/// По дизайну мы определили два типа контактов:
/// - ladder - игрок может карабкаться и не падать
/// - death - игрок проигрывает при контакте
enum ContactType {
  ladder,
  death;

  factory ContactType.fromString(String name) {
    return ContactType.values.firstWhere((v) => v.name == name);
  }
}

/// Сенсор - компонент для взаимодействия игрока с окружающим миром
/// Не является физическим телом в мире
/// Используется для зонирования карты на специфические области
/// Например:
/// - вода или шипы - игрок проигрывает при контакте
/// - лестница - игрок может по ней карабкаться
class Sensor extends BaseBody {
  Sensor({required super.position, super.size, super.polygon, required this.type}) : super(isSensor: true);

  final ContactType type;
}

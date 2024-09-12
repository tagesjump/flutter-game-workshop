import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:v2/src/bodies/base_body.dart';
import 'package:v2/src/bodies/flag.dart';
import 'package:v2/src/bodies/ground.dart';
import 'package:v2/src/bodies/item.dart';
import 'package:v2/src/bodies/lock.dart';
import 'package:v2/src/bodies/sensor.dart';

/// Игрок
class Player extends BaseBody with ContactCallbacks {
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
  static const _maxYSpeed = 50.0;

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
    if (_ladderContactCount > 0) {
      final yVelocityChange = -_maxYSpeed - body.linearVelocity.y;
      final yImpulse = body.mass * yVelocityChange;
      body.applyLinearImpulse(Vector2(0.0, yImpulse));
    } else if (_groundContactCount > 0) {
      final yImpulse = body.mass * -_maxJumpSpeed;
      body.applyLinearImpulse(Vector2(0.0, yImpulse));
    }
  }

  void moveDown() {
    if (_ladderContactCount > 0) {
      final yVelocityChange = _maxYSpeed - body.linearVelocity.y;
      final yImpulse = body.mass * yVelocityChange;
      body.applyLinearImpulse(Vector2(0.0, yImpulse));
    }
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

  void moveYStop() {
    final yImpulse = -body.linearVelocity.y * body.mass;
    body.applyLinearImpulse(Vector2(0.0, yImpulse));
  }

  int _groundContactCount = 0;
  int _ladderContactCount = 0;
  List<ItemType> inventory = [];

  @override
  void beginContact(Object other, Contact contact) {
    switch (other) {
      case Ground():
        _groundContactCount++;
      case Sensor():
        switch (other.type) {
          case ContactType.ladder:
            _ladderContactCount++;
            body.gravityOverride = Vector2.zero();
          case ContactType.death:
            game.gameOver();
        }
      case Item():
        inventory.add(other.type);
        world.remove(other);
      case Lock():
        if (inventory.contains(ItemType.key)) {
          inventory.remove(ItemType.key);
          world.remove(other);
        }
      case Flag():
        game.win();
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    if (other is Ground) {
      _groundContactCount--;
    }

    if (other is Sensor && other.type == ContactType.ladder) {
      _ladderContactCount--;
      if (_ladderContactCount <= 0) {
        body.gravityOverride = null;
      }
    }
  }
}

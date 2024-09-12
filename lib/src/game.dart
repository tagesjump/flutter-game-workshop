import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:v2/src/bodies/flag.dart';
import 'package:v2/src/bodies/ground.dart';
import 'package:v2/src/bodies/item.dart';
import 'package:v2/src/bodies/jumper.dart';
import 'package:v2/src/bodies/lock.dart';
import 'package:v2/src/bodies/sensor.dart';
import 'package:v2/src/game_assets.dart';
import 'package:v2/src/player.dart';

class MyGame extends Forge2DGame with KeyboardEvents {
  MyGame() : super(gravity: Vector2(0.0, 200.0));

  late GameSprites sprites;

  late TiledComponent mapComponent;
  late Player player;

  static const _worldScale = .5;

  @override
  Future<void> onLoad() async {
    sprites = GameSprites(this);
    await sprites.onLoad();

    await super.onLoad();

    camera.viewport.add(FpsTextComponent());

    mapComponent = await TiledComponent.load('level1.tmx', Vector2.all(18.0), prefix: 'assets/maps/');
    mapComponent.scale = Vector2.all(_worldScale);

    world.add(mapComponent);
    world.add(Ground(
      position: mapComponent.position,
      polygon: [
        Vector2.zero(),
        Vector2(mapComponent.size.x, 0.0),
        Vector2(mapComponent.size.x, mapComponent.size.y),
        Vector2(0.0, mapComponent.size.y),
      ],
    ));

    for (final l in mapComponent.tileMap.map.layers) {
      if (l is! ObjectGroup) continue;

      for (final object in l.objects) {
        final position = object.position.scaled(_worldScale);
        Vector2? size;
        List<Vector2>? polygon;

        if (object.isPolygon) {
          polygon = object.polygon.map((p) => Vector2(p.x, p.y).scaled(_worldScale)).toList();
        } else if (object.isRectangle) {
          size = object.size.scaled(_worldScale);
        } else {
          continue;
        }

        Component? component = switch (object.type) {
          'player' => Player(position: position, size: size!, radius: size.x / 2),
          'jumper' => Jumper(position: position, size: size!),
          'lock' => Lock(position: position, size: size!),
          'item' => Item(position: position, size: size!, type: ItemType.fromString(object.name)),
          'flag' => Flag(position: position, size: size!),
          // contact layers
          'ground' => Ground(position: position, size: size, polygon: polygon),
          'sensor' =>
            Sensor(position: position, size: size, polygon: polygon, type: ContactType.fromString(object.name)),
          String() => null,
        };

        if (component is Player) {
          player = component;
        }

        if (component != null) {
          world.add(component);
        }
      }
    }
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    bool isHandled = false;

    switch (event) {
      case KeyDownEvent() || KeyRepeatEvent():
        if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
          player.moveUp();
          isHandled = true;
        }

        if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
          player.moveRight();
          isHandled = true;
        }

        if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
          player.moveLeft();
          isHandled = true;
        }
      case KeyUpEvent():
        if (!keysPressed.contains(LogicalKeyboardKey.arrowLeft) &&
            !keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
          player.moveXStop();
          isHandled = true;
        }
    }

    if (isHandled) {
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  void gameOver() {
    // TODO: game over :(
  }

  void win() {
    // TODO: win! change level
  }
}

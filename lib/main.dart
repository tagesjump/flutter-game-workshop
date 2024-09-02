import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:v2/src/game.dart';

void main() {
  runApp(const GameWidget.controlled(gameFactory: MyGame.new));
}

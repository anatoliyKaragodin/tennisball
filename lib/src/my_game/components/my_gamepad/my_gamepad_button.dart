import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/foundation.dart';

import '../../my_game.dart';

class MyGamepadButton extends SpriteButtonComponent with HasGameRef<MyGame> {
  late String imgPath;
  final Function function;
  final Function onTapUpFunc;

  MyGamepadButton(
      {super.button,
      super.buttonDown,
      super.onPressed,
      super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.children,
      super.priority,
      required this.imgPath,
      required this.function,
      required this.onTapUpFunc});
  @override
  FutureOr<void> onLoad() {
    addButton();
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent _) {
    function();
    // changeImageForever();
    super.onTapDown(_);
  }

  @override
  void onTapUp(TapUpEvent _) {
    onTapUpFunc();
    super.onTapUp(_);
  }

  void addButton() async {
    var image = await Flame.images.load(imgPath);
    button = Sprite(image);
  }

  // void changeImageForever() async {
  //   var newImage = await Flame.images.load(imgPath);
  //   button = Sprite(newImage);
  //
  // }
}

import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';

import '../my_game.dart';

class MyBlock extends SpriteComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  late SpriteComponent spriteComponent;

  // late Vector2 ballPosition;

  @override
  FutureOr<void> onLoad() async {
    var ballImg = await Flame.images.load('Prep1.png');
    sprite = Sprite(ballImg);
    spriteComponent = SpriteComponent(sprite: sprite, size: Vector2(150, 150));
    add(CircleHitbox(
        radius: 60, anchor: const Anchor(-0.13, -0.13), isSolid: true));

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
  }
}

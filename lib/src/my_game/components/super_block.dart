import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';

import '../my_game.dart';

class MySuperBlock extends SpriteAnimationComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  late SpriteAnimationComponent spriteAnimationComponent;

  // late Vector2 ballPosition;

  @override
  FutureOr<void> onLoad() async {
    final sprites = [1, 2].map((i) => Sprite.load('PrepNumber$i.png'));
    final animation = SpriteAnimation.spriteList(
      await Future.wait(sprites),
      stepTime: 0.3,
    );
    spriteAnimationComponent = SpriteAnimationComponent(
      animation: animation,
      size: Vector2.all(150.0),
    );
    add(spriteAnimationComponent);
    add(CircleHitbox(
        radius: 68, anchor: const Anchor(-0.05, -0.05), isSolid: true));

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
  }
}

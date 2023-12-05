import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

import '../my_game.dart';

class Ring extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
  late SpriteComponent ring;

  // late Vector2 ballPosition;

  @override
  FutureOr<void> onLoad() async {
    var ballImg = await Flame.images.load('Ring.png');
    sprite = Sprite(ballImg);
    ring = SpriteComponent(sprite: sprite, size: Vector2(60, 110));
    var hitBox = CircleHitbox();
    hitBox
      ..anchor = const Anchor(-0.05, 0.21)
      ..scale = Vector2(0.9, 1.7);
    add(hitBox);

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
  }
}

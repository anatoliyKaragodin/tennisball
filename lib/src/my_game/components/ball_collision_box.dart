import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class BallCollisionBox extends PositionComponent with CollisionCallbacks {
  @override
  FutureOr<void> onLoad() {
    addCollisionBox();
    return super.onLoad();
  }

  void addCollisionBox() {
    var collisionBox = RectangleHitbox();
    collisionBox
      // ..isSolid = true
      ..size = Vector2(300, 300);
    // ..setColor(Color(100));
    add(collisionBox);
  }
}

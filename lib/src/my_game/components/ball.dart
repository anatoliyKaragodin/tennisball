import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:tennisball/src/my_game/components/ball_collision_box.dart';
import 'package:tennisball/src/my_game/components/block.dart';
import 'package:tennisball/src/my_game/components/ring.dart';
import 'package:tennisball/src/my_game/components/super_block.dart';

import '../my_game.dart';

class Ball extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
  late SpriteComponent ball;
  List<Ring> collidedRings = [];

  // late Vector2 ballPosition;

  @override
  FutureOr<void> onLoad() async {
    var ballImg = await Flame.images.load('Ball.png');
    sprite = Sprite(ballImg);
    ball = SpriteComponent(sprite: sprite, size: Vector2(100, 100));
    add(CircleHitbox());

    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is MyBlock) {
      _collisionWithBlock(intersectionPoints, other);
      _addCollisionCount();
    } else if (other is MySuperBlock) {
      _gameFinished();
      // _pauseGame();
    } else if (other is Ring) {
      _collisionWithRing(other);
      if (gameRef.world.ringsCount <= 0) {
        gameRef.isWin = true;
        _gameFinished();
        // _pauseGame();
      }
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  _collisionWithBlock(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // Find the center of the block
    final blockCenter = other.center;

    // Find the point of collision on the ball
    final collisionPoint = intersectionPoints.isNotEmpty
        ? intersectionPoints.reduce((a, b) => a + b) /
            intersectionPoints.length.toDouble()
        : position;

    // Calculate the normal vector
    final normalVector = (collisionPoint - blockCenter).normalized();

    // Calculate the incident vector (current ball velocity)
    final incidentVector = gameRef.world.ballVelocity.normalized();

    // Calculate the reflection vector using the reflection formula: R = I - 2 * (I dot N) * N
    final reflectionVector =
        incidentVector - normalVector * (2 * incidentVector.dot(normalVector));

    // Set the new ball velocity
    gameRef.world.ballVelocity
        .setFrom(reflectionVector * gameRef.world.ballVelocity.length);
  }

  void _addCollisionCount() {
    gameRef.world.collisionCount += 1;
  }

  void _pauseGame() {
    gameRef.paused = true;
  }

  void _collisionWithRing(Ring other) {
    gameRef.world.remove(other);
    gameRef.world.ringsCount--;
  }

  void _gameFinished() {
    gameRef.gameFinished = true;
  }
}

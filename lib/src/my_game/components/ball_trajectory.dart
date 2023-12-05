import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tennisball/src/my_game/my_game.dart';

class BallTrajectory extends PositionComponent with HasGameRef<MyGame> {
  List<Offset> trajectoryPoints = [];

  Paint trajectoryPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 5.0;

  @override
  void update(double dt) {
    updateTrajectoryPoints();
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    if (gameRef.world.myGamepad.showTrajectory) {
      canvas.drawLine(
        trajectoryPoints[0],
        trajectoryPoints[1],
        trajectoryPaint,
      );
    }
    super.render(canvas);
  }

  void updateTrajectoryPoints() {
    Vector2 initialPosition =
        gameRef.world.player.position.clone() + Vector2(150, 0);
    // debugPrint('PLAYER POSITION: ${gameRef.world.player.position}');

    // debugPrint('INITIAL TRAJECTORY POSITION: $initialPosition');
    Vector2 direction = gameRef.world.ballVelocity.normalized();
    double trajectoryLength = 200;

    Vector2 endPosition = initialPosition + direction * trajectoryLength;
    trajectoryPoints.clear();
    trajectoryPoints
        .addAll([initialPosition.toOffset(), endPosition.toOffset()]);
  }
}

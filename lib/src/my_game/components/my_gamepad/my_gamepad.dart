import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tennisball/src/my_game/components/player.dart';

import '../../my_game.dart';
import 'my_gamepad_button.dart';

class MyGamePad extends PositionComponent
    with HasGameRef<MyGame>, TapCallbacks {
  bool isMoveRight = false;
  bool isMoveLeft = false;
  bool isMoveBallTrajectoryRight = false;
  bool isMoveBallTrajectoryLeft = false;

  late MyGamepadButton hitButton;
  late MyGamepadButton hitButton2;
  bool showTrajectory = false;
  // List<Offset> trajectoryPoints = [];
  //
  // Paint trajectoryPaint = Paint()
  //   ..color = Colors.white
  //   ..strokeWidth = 8.0;

  static const imgPathList = [
    'Arrow.png',
    '1st stance.png',
    '2nd stance.png',
  ];

  @override
  FutureOr<void> onLoad() {
    addButtons();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    moveUser(dt);
    changeTrajectory(dt);
    // if (showTrajectory) {
    // updateTrajectoryPoints();
    // }
    super.update(dt);
  }

  void addButtons() {
    const double buttonPadding = 100;

    var funcList = [
      () {
        if (!gameRef.world.isHitStand) {
          isMoveRight = false;
          isMoveLeft = true;
          gameRef.world.player.player.current = PlayerAnimation.move;
        } else {
          isMoveBallTrajectoryRight = false;
          isMoveBallTrajectoryLeft = true;
        }
      },
      () {
        if (!gameRef.world.isHitStand) {
          isMoveLeft = false;
          isMoveRight = true;
          gameRef.world.player.player.current = PlayerAnimation.move;
        } else {
          isMoveBallTrajectoryRight = true;
          isMoveBallTrajectoryLeft = false;
        }
      },
      () {
        gameRef.world.myGamepad.remove(hitButton);
        gameRef.world.myGamepad.add(hitButton2);
        gameRef.world.isHitStand = true;
        showTrajectory = true;
      },
      () {
        if (!gameRef.world.isBallInGame) {
          gameRef.world.player.player.current = PlayerAnimation.hit;
          debugPrint('SET HIT STATE');
        }
      },
    ];
    var onTapUpFuncList = [
      () {
        isMoveRight = false;
        isMoveLeft = false;
        isMoveBallTrajectoryRight = false;
        isMoveBallTrajectoryLeft = false;
        gameRef.world.player.player.current = PlayerAnimation.idle;
      },
      () {
        isMoveLeft = false;
        isMoveRight = false;
        isMoveBallTrajectoryRight = false;
        isMoveBallTrajectoryLeft = false;
        gameRef.world.player.player.current = PlayerAnimation.idle;
      },
      () {},
    ];
    var leftButton = MyGamepadButton(
        imgPath: imgPathList[0],
        function: funcList[0],
        onTapUpFunc: onTapUpFuncList[0]);
    var rightButton = MyGamepadButton(
        imgPath: imgPathList[0],
        function: funcList[1],
        onTapUpFunc: onTapUpFuncList[0]);

    hitButton = MyGamepadButton(
        imgPath: imgPathList[1],
        function: funcList[2],
        onTapUpFunc: onTapUpFuncList[0]);
    hitButton2 = MyGamepadButton(
        imgPath: imgPathList[2],
        function: funcList[3],
        onTapUpFunc: onTapUpFuncList[2]);
    leftButton
      ..position = Vector2(50, 0)
      ..flipHorizontally();

    rightButton.position = leftButton.position + Vector2(buttonPadding, 0);
    hitButton.position = Vector2(7.5 * buttonPadding, 0);
    hitButton2.position = Vector2(7.5 * buttonPadding, 0);

    addAll([
      leftButton,
      rightButton,
      hitButton,
    ]);
  }

  void moveUser(double dt) {
    if (isMoveRight) {
      if (gameRef.world.player.x < 550) {
        gameRef.world.player.x += dt * 100;
        gameRef.world.ball.x = gameRef.world.player.position.x + 150;
      }
    } else if (isMoveLeft) {
      if (gameRef.world.player.x > -50) {
        gameRef.world.player.x -= dt * 100;
        gameRef.world.ball.x = gameRef.world.player.position.x + 150;
      }
    }
  }

  void changeTrajectory(double dt) {
    if (showTrajectory) {
      if (isMoveBallTrajectoryLeft &&
          gameRef.world.ballVelocity.x.abs() <= 300) {
        gameRef.world.ballVelocity.x -= dt * 100;
        gameRef.world.ballVelocity.x = gameRef.world.ballVelocity.x.abs() > 300
            ? -300
            : gameRef.world.ballVelocity.x;
        gameRef.world.ballVelocity.y =
            -800 + (gameRef.world.ballVelocity.x.abs());
        // debugPrint(gameRef.world.ballVelocity.toString());
      } else if (isMoveBallTrajectoryRight &&
          gameRef.world.ballVelocity.x.abs() <= 300) {
        gameRef.world.ballVelocity.x += dt * 100;
        gameRef.world.ballVelocity.x = gameRef.world.ballVelocity.x.abs() > 300
            ? 300
            : gameRef.world.ballVelocity.x;
        gameRef.world.ballVelocity.y =
            -800 + (gameRef.world.ballVelocity.x.abs());

        // debugPrint(gameRef.world.ballVelocity.toString());
      }
    }
  }

  // void resetMyGamepad() {
  //   showTrajectory = false;
  //   gameRef.world.isHitStand = false;
  //   gameRef.world.ballVelocity = Vector2(0, -800);
  //   gameRef.world.collisionCount = 0;
  // }

  void switchToHitButton1() {
    gameRef.world.myGamepad.remove(hitButton2);
    gameRef.world.myGamepad.add(hitButton);
    gameRef.world.isHitStand = false;
  }
}

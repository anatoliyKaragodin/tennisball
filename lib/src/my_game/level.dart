import 'dart:async';
import 'dart:math';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:tennisball/src/app/pages/game_field_page/model/game.dart';
import 'package:tennisball/src/my_game/components/ball_collision_box.dart';
import 'package:tennisball/src/my_game/components/ball_trajectory.dart';
import 'package:tennisball/src/my_game/components/block.dart';
import 'package:tennisball/src/my_game/components/player.dart';
import 'package:tennisball/src/my_game/components/ring.dart';
import 'package:tennisball/src/my_game/components/super_block.dart';

import '../utils/my_colors.dart';
import 'components/ball.dart';
import 'components/my_gamepad/my_gamepad.dart';
import 'my_game.dart';

class Level extends World with HasGameRef<MyGame>, TapCallbacks {
  late SpriteComponent background;
  late Ball ball;
  late MyPlayer player;
  late MyGamePad myGamepad;
  late MySuperBlock superBlock;
  int collisionCount = 0;
  TextComponent collisionCountTextComponent = TextComponent(text: '0');
  List<Ring> ringsList = [];
  List<Vector2> componentsAvailablePositions = [];

  bool matchIsEnded = false;
  bool isHitStand = false;
  Vector2 ballVelocity = Vector2(0, -800);

  bool isBallInGame = false;
  bool isNeedToResetBall = false;

  double componentsScale = 0.7;
  int ringsCount = 0;

  @override
  FutureOr<void> onLoad() async {
    createFieldOfGameComponents();
    await addBackground();
    addRings(gameRef.gameDifficulty);
    addBlocks(gameRef.gameDifficulty);
    addSuperBlock();
    addCollisionCount();
    addPlayer();
    addBall();
    addGamepad();
    addTrajectory();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (isBallInGame) {
      moveBall(dt);
    }
    updateCollisionText();
    checkNeedResetBall();
    updateGameAfterCollisions();
    // resetBall();
    super.update(dt);
  }

  Future<void> addBackground() async {
    var backgroundImg = await Images().load('Ffon.png');
    background = SpriteComponent(sprite: Sprite(backgroundImg));
    add(background);
  }

  void addBall() {
    const ballScale = 0.5;
    ball = Ball();
    ball
      ..anchor = Anchor.center
      ..scale = Vector2(1, 1) * ballScale
      ..position = player.position + Vector2(150, 0);
    // add(ball);
  }

  void addGamepad() {
    myGamepad = MyGamePad();
    var scale = 0.6;
    myGamepad
      ..scale = Vector2(1, 1) * scale
      ..position = Vector2(100, 1180);
    add(myGamepad);
  }

  // void resetBall() {
  //   const List<int> maxCollisionCountList = [8, 4, 2];
  //   if (collisionCount >=
  //       maxCollisionCountList[gameRef.gameDifficulty.index]) {
  //     myGamepad.resetMyGamepad();
  //   }
  // }

  void gameEnded() {
    matchIsEnded = true;
    gameRef.gameFinished = true;
  }

  void addRing() {
    var ring = Ring();
    var positionIndex =
        Random().nextInt(componentsAvailablePositions.length - 1);
    ring
      ..scale = Vector2(1, 1) * componentsScale * 1.1
      ..anchor = Anchor.center
      ..position = componentsAvailablePositions[positionIndex];
    componentsAvailablePositions.removeAt(positionIndex);

    ringsList.add(ring);
    ringsCount++;
  }

  void addBlock() {
    var block = MyBlock();
    var positionIndex =
        Random().nextInt(componentsAvailablePositions.length - 1);
    block
      ..scale = Vector2(1, 1) * componentsScale * 0.8
      ..anchor = Anchor.center
      ..position = componentsAvailablePositions[positionIndex];
    componentsAvailablePositions.removeAt(positionIndex);

    add(block);
  }

  void addSuperBlock() {
    superBlock = MySuperBlock();
    var positionIndex =
        Random().nextInt(componentsAvailablePositions.length - 1);
    superBlock
      ..scale = Vector2(1, 1) * componentsScale
      ..anchor = Anchor.center
      ..position = componentsAvailablePositions[positionIndex];
    componentsAvailablePositions.removeAt(positionIndex);
    add(superBlock);
  }

  void addPlayer() {
    player = MyPlayer();
    player.position = Vector2(300, 920);
    add(player);
  }

  void moveBall(double dt) {
    // debugPrint('MOVE BALL IN GAME');
    ball.position += ballVelocity * dt;
    // Check for collisions with the top and adjust velocity if needed
    if (ball.position.y <= ball.size.x / 2) {
      ball.position.y = ball.size.x / 2;
      ballVelocity.y = -ballVelocity.y; // Reverse the vertical velocity
    }

    // Check for collisions with the bottom and adjust velocity if needed
    if (ball.position.y >= 1170 - ball.size.y) {
      ball.position.y = 1170 - ball.size.y;
      ballVelocity.y = -ballVelocity.y; // Reverse the vertical velocity
    }

    // Check for collisions with the sides and adjust velocity if needed
    if (ball.position.x <= ball.size.x / 2) {
      ball.position.x = ball.size.x / 2;
      ballVelocity.x = -ballVelocity.x; // Reverse the horizontal velocity
    }
    if (ball.position.x >= gameRef.size.x - ball.size.x / 2) {
      ball.position.x = gameRef.size.x - ball.size.x / 2;
      ballVelocity.x = -ballVelocity.x; // Reverse the horizontal velocity
    }
  }

  void createFieldOfGameComponents() {
    double fieldWidth = 720;
    double fieldHeight = 800;
    double squareSize = 140;
    for (double x = squareSize / 2; x < fieldWidth; x += squareSize) {
      for (double y = squareSize / 2; y < fieldHeight; y += squareSize) {
        componentsAvailablePositions.add(Vector2(x, y));
      }
    }
    // debugPrint(componentsAvailablePositions.toString());
  }

  void addRings(GameDifficulty difficulty) {
    const List<int> countOgRingsList = [3, 5, 8];
    for (int i = 0; i < countOgRingsList[difficulty.index]; i++) {
      addRing();
    }
    addAll(ringsList);
  }

  void addBlocks(GameDifficulty difficulty) {
    const List<int> countOgRingsList = [1, 2, 3];
    for (int i = 0; i < countOgRingsList[difficulty.index]; i++) {
      addBlock();
    }
  }

  void addCollisionCount() {
    collisionCountTextComponent
      ..anchor = const Anchor(-3.18, -1.4)
      ..position = superBlock.position;
    add(collisionCountTextComponent);
  }

  void updateCollisionText() {
    collisionCountTextComponent.text = collisionCount.toString();
  }

  void updateGameAfterCollisions() {
    if (isNeedToResetBall) {
      myGamepad.switchToHitButton1(); // Переключаемся на кнопку hit1
      isBallInGame = false;
      isHitStand = false;
      remove(ball);
      ballVelocity = Vector2(0, -800);
      player.position =
          Vector2(300, 920); // Возвращаем игрока на начальную позицию
      collisionCount = 0; // Сбрасываем счетчик столкновений
    }
  }

  void checkNeedResetBall() {
    const List<int> maxCollisionCountList = [8, 4, 2];
    if (collisionCount >= maxCollisionCountList[gameRef.gameDifficulty.index]) {
      isNeedToResetBall = true;
    } else {
      isNeedToResetBall = false;
    }
  }

  void addTrajectory() {
    BallTrajectory ballTrajectory = BallTrajectory();
    add(ballTrajectory);
  }
}

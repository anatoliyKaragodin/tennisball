import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:tennisball/src/my_game/my_game.dart';

enum PlayerAnimation { idle, move, hit }

class MyPlayer extends SpriteAnimationGroupComponent with HasGameRef<MyGame> {
  late SpriteAnimationGroupComponent player;
  late SpriteAnimation move;
  late SpriteAnimation idle;
  late SpriteAnimation hit;

  @override
  FutureOr<void> onLoad() {
    addAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // debugPrint('PLAYER STATE : ${player.current}');
    super.update(dt);
  }

  void addAnimations() async {
    await _setMoveAnimation();
    await _setIdleAnimation();
    await _setHitAnimation();

    player = SpriteAnimationGroupComponent<PlayerAnimation>(
      animations: {
        PlayerAnimation.move: move,
        PlayerAnimation.idle: idle,
        PlayerAnimation.hit: hit,
      },
      current: PlayerAnimation.idle,
    );

    player.animationTickers?[PlayerAnimation.hit]?.onComplete = () {
      _onHitAnimationComplete();
    };
    add(player);
  }

  _setMoveAnimation() async {
    final spritesLeft =
        [1, 2, 3, 4].map((i) => Sprite.load('Player run$i.png'));
    final animation = SpriteAnimation.spriteList(
      await Future.wait(spritesLeft),
      stepTime: 0.3,
    );
    move = animation;
  }

  _setIdleAnimation() async {
    final spritesLeft = Sprite.load('Player stand.png');
    final animation = SpriteAnimation.spriteList(
      await Future.wait([spritesLeft]),
      stepTime: 0.3,
    );
    idle = animation;
  }

  _setHitAnimation() async {
    final spritesLeft =
        [1, 2, 3, 4].map((i) => Sprite.load('Player hit$i.png'));
    final SpriteAnimation animation = SpriteAnimation.spriteList(
      await Future.wait(spritesLeft),
      stepTime: 0.3,
      loop: false,
    );
    hit = animation;
  }

  void _onHitAnimationComplete() {
    player.current = PlayerAnimation.idle;
    debugPrint('SET IDLE STATE');
    gameRef.world.add(gameRef.world.ball);
    gameRef.world.isBallInGame = true;
    gameRef.world.myGamepad.showTrajectory = false;
    player.animationTickers?[PlayerAnimation.hit]?.reset();
  }
}

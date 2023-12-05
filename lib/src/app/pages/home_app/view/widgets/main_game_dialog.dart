import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tennisball/src/app/pages/game_field_page/model/game.dart';
import 'package:tennisball/src/utils/library.dart';

import '../../../../../universal_widgets/my_button.dart';
import '../../../../../universal_widgets/my_text_button.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/my_colors.dart';
import '../../../../../utils/my_parameters.dart';
import '../../../game_field_page/controller/game_page_controller.dart';

class MainGameDialog extends ConsumerStatefulWidget {
  const MainGameDialog({super.key});

  @override
  ConsumerState createState() => _MainGameDialogState();
}

class _MainGameDialogState extends ConsumerState<MainGameDialog> {
  TextEditingController betController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.longestSide;
    final width = MediaQuery.of(context).size.shortestSide;

    final game = ref.watch(gameProvider);
    return Container(
      height: height * 0.6,
      width: width * 0.9,
      decoration: BoxDecoration(
          borderRadius: MyParameters(context).roundedBorders,
          color: MyColors.whiteColor!.withOpacity(0.6)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildBetContainer(game, width, height),
          buildDifficultyContainer(width, height, game),
          buildRewardText(game),
        ],
      ),
    );
  }

  Text buildRewardText(GameState game) {
    const xList = [1.2, 1.5, 2];
    return Text(
      textAlign: TextAlign.center,
      'Reward x ${xList[game.gameDifficulty.index]}',
    );
  }

  Column buildDifficultyContainer(double width, double height, GameState game) {
    const difficultyLabels = ['EASY', 'MEDIUM', 'HARD'];
    return Column(
      children: [
        const Text(
          textAlign: TextAlign.center,
          'Difficulty',
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.02),
          child: SizedBox(
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                  3,
                  (index) => Opacity(
                        opacity: game.gameDifficulty.index == index ? 1 : 0.7,
                        child: MyButton(
                          text: difficultyLabels[index],
                          function: () {
                            GameControl.setDifficulty(ref, index);
                          },
                          height: height,
                          width: width * 0.27,
                        ),
                      )),
            ),
          ),
        ),
      ],
    );
  }

  Column buildBetContainer(GameState game, double width, double height) {
    const betsList = [10, 20, 50];
    return Column(
      children: [
        Text(
          textAlign: TextAlign.center,
          'How many coins are you willing to bet?\n\nyour coins: ${game.userMoney}',
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.02),
          child: SizedBox(
            width: width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                  3,
                  (index) => Opacity(
                        opacity: game.bet == betsList[index] ? 1 : 0.7,
                        child: MyButton(
                          text: betsList[index].toString(),
                          function: () {
                            if (!game.isBetted) {
                              GameControl.onChooseBet(ref, betsList[index]);
                            }
                          },
                          height: height,
                          width: width * 0.2,
                        ),
                      )),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:tennisball/src/utils/library.dart';

import '../../../../../universal_widgets/my_button.dart';
import '../../../../../universal_widgets/my_text_button.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/my_colors.dart';
import '../../../../../utils/my_parameters.dart';
import '../../../game_field_page/controller/game_page_controller.dart';

class ResultDialog extends ConsumerStatefulWidget {
  const ResultDialog({super.key});

  @override
  ConsumerState createState() => _ResultDialogState();
}

class _ResultDialogState extends ConsumerState<ResultDialog> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.longestSide;
    final width = MediaQuery.of(context).size.shortestSide;
    final orientationPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final game = ref.watch(gameProvider);
    final isWin = game.isWinGame;
    const betXList = [1.2, 1.5, 2];
    final betX = betXList[game.gameDifficulty.index];
    return Container(
        height: height * 0.2,
        width: width * 0.6,
        decoration: BoxDecoration(
            borderRadius: MyParameters(context).roundedBorders,
            color: MyColors.whiteColor!.withOpacity(0.8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (!isWin)
              Text(
                'DEFEAT',
                textAlign: TextAlign.center,
                style: MyParameters(context).middleTextStyle,
              ),
            // if(!isDraw)Image.asset(isWin?Constants.winnerImg:Constants.looseImg),

            if (isWin)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You win: ${(game.bet * betX).toInt()}  '),
                  // Image.asset(Constants.coinsImg, height: height*0.03,)
                ],
              ),
            MyButton(
              text: 'Close',
              function: () {
                GameControl.onCloseResultTap(ref, isWin);
              },
              height: height,
              width: width * 0.2,
            ),
          ],
        ));
  }
}

import 'package:tennisball/src/utils/library.dart';

import '../../../../../universal_widgets/my_button.dart';
import '../../../../../universal_widgets/my_text_button.dart';
import '../../../../../utils/my_colors.dart';
import '../../../../../utils/my_parameters.dart';
import '../../../game_field_page/controller/game_page_controller.dart';

class RestartGameDialog extends ConsumerStatefulWidget {
  const RestartGameDialog({super.key});

  @override
  ConsumerState createState() => _RestartGameDialogState();
}

class _RestartGameDialogState extends ConsumerState<RestartGameDialog> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.longestSide;
    final width = MediaQuery.of(context).size.shortestSide;
    final orientationPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final game = ref.watch(gameProvider);
    return Container(
        height: height * 0.3,
        width: width * 0.6,
        decoration: BoxDecoration(
            borderRadius: MyParameters(context).roundedBorders,
            color: MyColors.whiteColor!.withOpacity(0.8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'GAME OVER!\n\nTotal score:\n${game.userScore}',
              textAlign: TextAlign.center,
              style: MyParameters(context).middleTextStyle,
            ),
            MyButton(
              text: 'New game',
              function: () {
                GameControl.onRestartGameTap(ref);
              },
              height: height,
              width: width * 0.31,
            ),
          ],
        ));
  }
}

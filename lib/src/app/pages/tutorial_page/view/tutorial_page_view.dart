import 'dart:async';
import '../../../../universal_widgets/my_button.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/library.dart';
import '../../../../utils/my_colors.dart';
import '../../../../utils/my_parameters.dart';
import '../controller/tutorial_page_controller.dart';

class TutorialPageView extends ConsumerStatefulWidget {
  const TutorialPageView({super.key});
  final route = 'tutorial page';

  @override
  ConsumerState createState() => _TutorialPageViewState();
}

class _TutorialPageViewState extends ConsumerState<TutorialPageView> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,]);
    final height = MediaQuery.of(context).size.longestSide;
    final width = MediaQuery.of(context).size.shortestSide;
    final orientationPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
            child: Scaffold(
                body: SingleChildScrollView(
                    physics: orientationPortrait
                        ? const NeverScrollableScrollPhysics()
                        : const AlwaysScrollableScrollPhysics(),
                    child: Center(
                        child: SizedBox(
                      height: height,
                      width: width,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          // Image.asset(Constants.tutorialBackImg),
                          Positioned(
                            top: height * 0.25,
                            child: SizedBox(
                              width: width * 0.8,
                              child: Text(
                                Constants.tutorialText,
                                style: TextStyle(
                                    color: MyColors.blackColor87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.68),
                            child: MyButton(
                              text: 'Ok',
                              function: () =>
                                  TutorialPageController.onCloseTap(context),
                              height: height,
                              width: width * 0.2,
                            ),
                          )
                        ],
                      ),
                    ))))));
  }
}

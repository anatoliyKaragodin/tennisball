import 'package:tennisball/src/app/pages/tutorial_page/view/tutorial_page_view.dart';

import '../../../utils/library.dart';

class StartPageView extends StatelessWidget {
  const StartPageView({super.key});

  final route = 'my app start page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.pushNamed(context, const TutorialPageView().route);
        },
        child: Center(
          child: Stack(alignment: Alignment.center, children: [
            SizedBox(
              child: Image.asset('assets/images/Preloader.png'),
            ),
            SizedBox(
              child: Image.asset('assets/images/Tap to start.png'),
            ),
          ]),
        ),
      ),
    );
  }
}

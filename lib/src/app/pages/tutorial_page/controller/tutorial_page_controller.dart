import '../../../../utils/library.dart';
import '../../home_app/view/home_app_page.dart';

class TutorialPageController {
  static onCloseTap(BuildContext context) {
    Navigator.pushNamed(context, const HomeAppPage().route);
  }
}

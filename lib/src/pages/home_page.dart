import 'package:flutter/foundation.dart';
import 'package:tennisball/src/app/pages/start_page/start_page_view.dart';
import '../app/pages/home_app/view/home_app_page.dart';

import '../../main.dart';
import '../app/pages/tutorial_page/view/tutorial_page_view.dart';
import '../utils/library.dart';
import 'home_page_clear.dart';
import 'home_page_web.dart';

class HomePage extends ConsumerStatefulWidget {
  final String route = 'home page';

  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final List<Widget> homePages = <Widget>[
    const StartPageView(),
    const HomePageWeb(),
    const HomePageClear(),
  ];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _changeLoadingStatus();
  }

  void _changeLoadingStatus() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (kDebugMode) {
    //   print('__________________________HOME PAGE INDEX: $homePageIndex');
    // }

    return SafeArea(
        child: isLoading ? const HomePageClear() : homePages[homePageIndex]);
  }
}

import '../utils/library.dart';

class HomePageClear extends StatefulWidget {
  final String route = 'clear page';

  const HomePageClear({Key? key}) : super(key: key);

  @override
  State<HomePageClear> createState() => _HomePageClearState();
}

class _HomePageClearState extends State<HomePageClear> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(alignment: Alignment.center, children: [
          SizedBox(
            child: Image.asset('assets/images/Preloader.png'),
          ),
          SizedBox(
            child: Image.asset('assets/images/Loading.png'),
          ),
        ]),
      ),
    );
  }
}

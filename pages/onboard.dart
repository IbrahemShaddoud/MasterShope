import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:mastershop/pages/signin.dart';

class IntroOverboardPage extends StatefulWidget {
  static const routeName = '/IntroOverboardPage';

  @override
  _IntroOverboardPageState createState() => _IntroOverboardPageState();
}

class _IntroOverboardPageState extends State<IntroOverboardPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// -----------------------------------------------
    /// Build main content with Scaffold widget.
    /// -----------------------------------------------
    return Scaffold(
      key: _globalKey,

      /// -----------------------------------------------
      /// Build Into with OverBoard widget.
      /// -----------------------------------------------
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return LogIn();
          }));
        },
        finishCallback: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return LogIn();
          }));
        },
      ),
    );
  }

  /// -----------------------------------------------
  /// making list of PageModel needed to pass in OverBoard constructor.
  /// -----------------------------------------------
  final pages = [
    PageModel(
        color: Color.fromARGB(255, 163, 208, 222),
        imageAssetPath: 'images/intro/1.png',
        title: 'Best prices & offers',
        body: 'We give you the best price ever',
        doAnimateImage: true),
    PageModel(
        color: Color.fromARGB(255, 186, 127, 170),
        imageAssetPath: 'images/intro/2.png',
        title: 'Add to cart & make purchase',
        body: 'Find your fivorate product and pay what you want',
        doAnimateImage: true),
    PageModel(
        color: Color.fromARGB(255, 158, 150, 183),
        imageAssetPath: 'images/intro/3.png',
        title: 'Order deliveery',
        body:
            'Your order will be in front of your doorstep as soon as possiple',
        doAnimateImage: true),
  ];
}

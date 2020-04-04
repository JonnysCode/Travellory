import 'package:flutter/material.dart';
import 'package:travellory/widgets/font_widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        key: Key('home_page'),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 30,
              top: 30,
              child: Image(
                height: 100,
                image: AssetImage('assets/images/home/011-cloud.png'),
              ),
            ),
            Positioned(
              top: 100,
              left: 110,
              child: FashionFetishText(
                text: '24\u00B0',
                size: 24,
                color: Colors.black87,
                fontWeight: FashionFontWeight.BOLD,
              ),
            ),
            Positioned(
              top: 45,
              left: 175,
              right: 20,
              child: Container(
                child: FashionFetishText(
                  text: 'Get ready Bill!',
                  size: 24,
                  fontWeight: FashionFontWeight.HEAVY,
                  height: 1.2,
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: 175,
              right: 40,
              child: Container(
                child: FashionFetishText(
                  text: "You're about to take off.",
                  size: 18,
                  color: Colors.black54,
                  fontWeight: FashionFontWeight.BOLD,
                  height: 1.2,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
                    boxShadow: [
                      BoxShadow(blurRadius: 18, color: Colors.black.withOpacity(.2), offset: Offset(0.0, -6.0))
                    ],
                  ),
                  child: Container(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

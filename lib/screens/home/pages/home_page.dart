import 'package:flutter/material.dart';
import 'package:travellory/screens/trip/schedule/trip_schedule.dart';
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
              top: 40,
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
              top: 75,
              left: 175,
              right: 40,
              child: Container(
                child: Text(
                  "Your trip to Los Angeles starts in 1 day. Pack your luggage now.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.8,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,//Color(0xFFeff5f7),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
                    boxShadow: [
                      BoxShadow(blurRadius: 18, color: Colors.black.withOpacity(.2), offset: Offset(0.0, -6.0))
                    ],
                  ),
                  child: Schedule(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

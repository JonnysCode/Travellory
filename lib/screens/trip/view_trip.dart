import 'package:flutter/material.dart';

class ViewTrip extends StatefulWidget {
  @override
  _ViewTripState createState() => _ViewTripState();
}

class _ViewTripState extends State<ViewTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
                color: Color(0xFFCCD7DD),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    right: -30,
                    child: FlatButton.icon(
                        onPressed: () => { Navigator.pushReplacementNamed(context, '/home') },
                        icon: Icon(Icons.clear, color: Colors.red, size: 32),
                        label: Text('')
                    ),
                  ),
                  Positioned(
                    top: -30,
                    left: -40,
                    child: Container(
                      height: 220,
                      width: 220,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/home/trip/trip_01.png"),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 180,
                    child: Container(
                      padding: EdgeInsets.only(top: 40, left: 10, right: 10),
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width,
                      constraints: BoxConstraints(
                          maxHeight: 300.0,
                          maxWidth: MediaQuery.of(context).size.width - 200,
                          minWidth: 150.0,
                          minHeight: 150.0
                      ),
                      child: Text(
                        'Beach Relaxation',
                        style: TextStyle(
                          fontFamily: 'FashionFetish',
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                          letterSpacing: -2.0,
                          height: 1.05
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          '03.04.2020 - 17.04.2020',
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'FashionFetish',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: -2.0,
                            height: 1.25
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.redAccent,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                'Maledives',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'FashionFetish',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                  letterSpacing: -1.0,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

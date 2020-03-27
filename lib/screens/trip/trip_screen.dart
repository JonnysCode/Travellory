import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/widgets/font_widgets.dart';

class TripScreen extends StatefulWidget {
  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  @override
  Widget build(BuildContext context) {
    final TripModel _tripModel = ModalRoute.of(context).settings.arguments;

    void _openHomeScreen(){
      Navigator.pop(context);
    }

    Widget _subsection(String title){
      return Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 16,
              width: 240,
              child: FashionFetishText(
                text: title,
                size: 24,
                fontWeight: FashionFontWeight.HEAVY,
              ),
            ),
            Positioned(
              top: 17,
              right: 34,
              child: Container(
                child: FashionFetishText(
                  text: 'Add',
                  size: 16,
                  fontWeight: FashionFontWeight.BOLD,
                  color: Colors.black45,
                ),
              ),
            ),
            Positioned(
              top: 6,
              right: 0,
              child: GestureDetector(
                onTap: () => {},
                child: Container(
                  height: 28,
                  width: 28,
                  padding: EdgeInsets.only(top: 20, right: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/home/trip/add.png"),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _cardCarousel(){
      return Container(
        height: 80,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                child: Center(child: Text('Entry')),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      );
    }

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
                    right: 0,
                    child: IconButton(
                      onPressed: () => _openHomeScreen(),
                      icon: FaIcon(FontAwesomeIcons.times),
                      iconSize: 26,
                      color: Colors.red,
                    ),
                  ),
                  Positioned(
                    top: -30,
                    left: -40,
                    child: Hero(
                      tag: 'trip_image' + _tripModel.index.toString(),
                      child: Container(
                        height: 220,
                        width: 220,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(_tripModel.imagePath),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.bottomCenter,
                          ),
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
                          maxHeight: 100.0,
                          maxWidth: MediaQuery.of(context).size.width - 200
                      ),
                      child: FashionFetishText(
                        text: _tripModel.name,
                        size: 24,
                        fontWeight: FashionFontWeight.HEAVY,
                        height: 1.05,
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
                        FashionFetishText(
                         text: 'From: ' + DateConverter.toShortenedMonthString( _tripModel.startDate)
                              + '\n'
                              + 'To: ' + DateConverter.toShortenedMonthString( _tripModel.endDate),
                          color: Colors.black54,
                          fontWeight: FashionFontWeight.BOLD,
                          size: 14,
                          height: 1.25
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.locationArrow,
                              size: 15,
                              color: Colors.redAccent,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6, left: 3),
                              child: FashionFetishText(
                                text: _tripModel.destination,
                                size: 14,
                                fontWeight: FashionFontWeight.HEAVY,
                                color: Colors.black54,
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
            Expanded(
               child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _subsection('Flight'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _cardCarousel(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _subsection('Accommodation'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _cardCarousel(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _subsection('Attractions'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _cardCarousel(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _subsection('Car rental'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _cardCarousel(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _subsection('Transportation'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _cardCarousel(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}

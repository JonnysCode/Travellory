import 'package:flutter/material.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/trip/trip_header.dart';

class TripScreen extends StatefulWidget {
  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  @override
  Widget build(BuildContext context) {
    TripModel _tripModel = ModalRoute.of(context).settings.arguments;

    void _openBooking(String bookingSite){
      Navigator.pushNamed(context, bookingSite, arguments: _tripModel);
    }

    Widget _subsection(String title, String route){
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
                fontWeight: FashionFontWeight.heavy,
              ),
            ),
            Positioned(
              top: 17,
              right: 34,
              child: FashionFetishText(
                text: 'Add',
                size: 16,
                fontWeight: FashionFontWeight.bold,
                color: Colors.black45,
              ),
            ),
            Positioned(
              top: 6,
              right: 0,
              child: GestureDetector(
                onTap: () => _openBooking(route),
                child: Container(
                  height: 28,
                  width: 28,
                  padding: EdgeInsets.only(top: 20, right: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/home/trip/add.png'),
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
          itemBuilder: (context, index) =>
            Padding(
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
            ),
          separatorBuilder: (context, index) => const Divider(),
        ),
      );
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            TripHeader(_tripModel),
            Expanded(
               child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _subsection('Flight', '/booking/flight'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _cardCarousel(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _subsection('Accommodation', '/booking/accommodation'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _cardCarousel(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _subsection('Activities', '/booking/activity'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _cardCarousel(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _subsection('Car rental', '/booking/rentalCar'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _cardCarousel(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: _subsection('Transportation', '/booking/publicTransport'),
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

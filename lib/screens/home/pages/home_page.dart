import 'package:flutter/material.dart';
import 'package:travellory/screens/trip/booking.dart';
import 'package:travellory/widgets/buttons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('home_page'),
      body: Center(
        child: filledButton(
            "ADD BOOKING",
            Colors.white,
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor,
            Colors.white, () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Booking()),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigator.pushNamed(context, '/booking');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Booking()),
          );
        },
        label: Text('Plan and manage trip itinerary'),
        icon: Icon(Icons.thumb_up),
        backgroundColor: Colors.pink,
      ),
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        key: Key('home_page'),
//        backgroundColor: Theme.of(context).primaryColor,
//        body: Column(
//          children: <Widget>[
//            Padding(
//              child: Container(
//                child: Center(
//                  child: filledButton(
//                      "ADD BOOKING",
//                      Colors.white,
//                      Theme.of(context).primaryColor,
//                      Theme.of(context).primaryColor,
//                      Colors.white, () async {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => Booking()),
//                    );
//                  }),
//                ),
//              ),
//              padding: const EdgeInsets.only(top: 60, left: 120, right: 120),
//            ),
//          ],
//        ));
//  }
}

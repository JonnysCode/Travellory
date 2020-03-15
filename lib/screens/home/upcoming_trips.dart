import 'package:flutter/material.dart';

class UpcomingTrips extends StatefulWidget {
  @override
  _UpcomingTripsState createState() => _UpcomingTripsState();
}

class _UpcomingTripsState extends State<UpcomingTrips> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0)),
                child: Container(
                  child: Column(
                    children: <Widget>[

                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 0.95,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

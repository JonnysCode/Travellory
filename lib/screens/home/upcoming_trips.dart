import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:travellory/screens/home/home.dart';

class UpcomingTrips extends StatefulWidget {
  @override
  _UpcomingTripsState createState() => _UpcomingTripsState();
}

class _UpcomingTripsState extends State<UpcomingTrips> {
  static final _heightOfNavbar = 68;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static final _pageController = PageController(
    initialPage: 0,
  );
  
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    _pageController.animateToPage(
        _selectedIndex,
        duration: Duration(milliseconds: 1000),
        curve: Curves.linear
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: PageView(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: (MediaQuery.of(context).size.height - _heightOfNavbar) * 0.05,
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
                              // TODO: Add data
                            ],
                          ),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          height: (MediaQuery.of(context).size.height - _heightOfNavbar) * 0.95,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.blue,
            ),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.green,
            )
          ],
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0)),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(blurRadius: 30, color: Colors.black.withOpacity(.25))
            ]),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
                child: GNav(
                    gap: 8,
                    activeColor: Colors.white,
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    duration: Duration(milliseconds: 1000),
                    tabBackgroundColor: Theme.of(context).primaryColor,
                    color: Theme.of(context).primaryColor,
                    tabs: [
                      GButton(
                        icon: Icons.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.calendar_today,
                        text: 'Calendar',
                      ),
                      GButton(
                        icon: Icons.map,
                        text: 'Map',
                      ),
                      GButton(
                        icon: Icons.person,
                        text: 'Profile',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });

                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:travellory/screens/home/pages/calendar_page.dart';
import 'package:travellory/screens/home/pages/home_page.dart';
import 'package:travellory/screens/home/pages/map_page.dart';
import 'package:travellory/screens/home/pages/profile_page.dart';
import 'package:travellory/widgets/layout.dart';

class UpcomingTrips extends StatefulWidget {
  @override
  _UpcomingTripsState createState() => _UpcomingTripsState();
}

class _UpcomingTripsState extends State<UpcomingTrips> {
  static final _heightOfNavBar = 68;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static final _pageController = PageController(
    initialPage: 0,
  );

  int _selectedIndex = 0;

  List<List<Widget>> _pages = [
    homePage(),
    calendarPage(),
    mapPage(),
    profilePage()
  ];

  List<Widget> _layoutPages(){
    List<Widget> layoutPages = List();
    for(List<Widget> page in _pages){
      layoutPages.add(mainPageLayout(context, (MediaQuery.of(context).size.height - _heightOfNavBar), page));
    }
    return layoutPages;
  }

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
          children: _layoutPages(),
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

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:travellory/screens/bookings/view_flight.dart';
import 'package:travellory/screens/bookings/view_rental_car.dart';
import 'package:travellory/screens/home/pages/calendar_page.dart';
import 'package:travellory/screens/home/pages/home_page.dart';
import 'package:travellory/screens/home/pages/map_page.dart';
import 'package:travellory/screens/home/pages/profile_page.dart';
import 'package:travellory/widgets/layout.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const int _animationSpeed = 800;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _pages = <Widget>[
    HomePage(),
    CalendarPage(),
    MapPage(),
    ProfilePage(),
    FlightView(),
  ];

  PageController _pageController;
  int _prevSelectedIndex = 0;
  int _navBarIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> _layoutPages(){
    final layoutPages = <Widget>[];
    for(final page in _pages){
      layoutPages.add(mainPageLayout(context, MediaQuery.of(context).size.height, page));
    }
    return layoutPages;
  }

  void _setNavBarIndex(int index){
    setState(() {
      _navBarIndex = index;
    });
    _animateToPage();
  }

  void _setNavIndices(int index){
    if(_navBarIndex > _prevSelectedIndex){
      _prevSelectedIndex++;
    } else if (_navBarIndex < _prevSelectedIndex){
      _prevSelectedIndex--;
    } else {
      setState(() {
        _prevSelectedIndex = index;
        _navBarIndex = index;
      });
      _animateToPage();
    }
  }

  void _animateToPage(){
    if(_pageController.hasClients){
      _pageController.animateToPage(
          _navBarIndex,
          duration: const Duration(milliseconds: _animationSpeed),
          curve: Curves.ease
      );
    }
  }

  Widget _navigationBar() {
      return DecoratedBox(
        key: Key('nav_bar'),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: <BoxShadow>[
            BoxShadow(blurRadius: 12, color: Colors.black.withOpacity(.1), offset: Offset(0.0, -3.0))
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0)),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
                child: GNav(
                    gap: 8,
                    activeColor: Colors.white,
                    iconSize: 22,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    duration: Duration(milliseconds: _animationSpeed),
                    tabBackgroundColor: Theme.of(context).primaryColor,
                    color: Theme.of(context).primaryColor,
                    tabs: <GButton>[
                      GButton(
                        key: Key('nav_home_button'),
                        icon: FontAwesomeIcons.suitcaseRolling,
                        text: 'Home',
                      ),
                      GButton(
                        key: Key('nav_calendar_button'),
                        icon: FontAwesomeIcons.calendarAlt,
                        text: 'Calendar',
                      ),
                      GButton(
                        key: Key('nav_map_button'),
                        icon: FontAwesomeIcons.globeAfrica,
                        text: 'Map',
                      ),
                      GButton(
                        key: Key('nav_profile_button'),
                        icon: FontAwesomeIcons.userAlt,
                        text: 'Profile',
                      ),
                      GButton(
                        key: Key('nav_profile_button'),
                        icon: FontAwesomeIcons.plane,
                        text: 'Plane',
                      ),
                    ],
                    selectedIndex: _navBarIndex,
                    onTabChange: (index) => _setNavBarIndex(index),
                ),
              ),
            ),
          ),
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) => _setNavIndices(index),
            children: _layoutPages(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: _navigationBar()
          ),
        ],
      ),
    );
  }
}

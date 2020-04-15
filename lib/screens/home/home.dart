import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/screens/bookings/view_accommodation.dart';
import 'package:travellory/screens/bookings/view_public_transport.dart';
import 'package:travellory/screens/bookings/view_rental_car.dart';
import 'package:travellory/screens/home/pages/calendar_page.dart';
import 'package:travellory/screens/home/pages/friends_page.dart';
import 'package:travellory/screens/home/pages/home_page.dart';
import 'package:travellory/screens/home/pages/map_page.dart';
import 'package:travellory/screens/home/pages/profile_page.dart';
import 'package:travellory/screens/bookings/view_flight.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const int _animationSpeed = 200;
  final List<Widget> _pages = <Widget>[
    HomePage(),
    CalendarPage(),
    //FlightView(),
    //RentalCarView(),
    //PublicTransportView(),
    AccommodationView(),
    //MapPage(),
    FriendsPage(),
    ProfilePage(),
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

  Widget _customNavigationBar(){
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(blurRadius: 50, color: Colors.black.withOpacity(.3), offset: Offset(0.0, -0.0))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        child: CustomNavigationBar(
          key: Key('key_bar'),
          iconSize: 22.0,
          selectedColor: Color(0xff040307),
          strokeColor: Color(0x90040307),
          unSelectedColor: Color(0xffacacac),
          backgroundColor: Colors.white,
          currentIndex: _navBarIndex,
          onTap: (index) => _setNavBarIndex(index),
          items: [
            CustomNavigationBarItem(
              icon: FontAwesomeIcons.suitcaseRolling,
            ),
            CustomNavigationBarItem(
              icon: FontAwesomeIcons.calendarAlt,
            ),
            CustomNavigationBarItem(
              icon: FontAwesomeIcons.globeAfrica,
            ),
            CustomNavigationBarItem(
              icon: FontAwesomeIcons.addressBook,
            ),
            CustomNavigationBarItem(
              icon: FontAwesomeIcons.user,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) => _setNavIndices(index),
            children: _pages,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _customNavigationBar(),
          ),
        ],
      ),
    );
  }
}

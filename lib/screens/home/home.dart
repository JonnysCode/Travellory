import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
  static final _heightOfNavBar = 68;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _pages = [
    HomePage(),
    CalendarPage(),
    MapPage(),
    ProfilePage()
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
    List<Widget> layoutPages = List();
    for(Widget page in _pages){
      layoutPages.add(mainPageLayout(context, (MediaQuery.of(context).size.height), page));
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
          duration: const Duration(milliseconds: 1000),
          curve: Curves.ease
      );
    }
  }

  Widget _navigationBar(){
      return DecoratedBox(
        key: Key('nav_bar'),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black.withOpacity(.1), offset: Offset(0.0, -3.0))],
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
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    duration: Duration(milliseconds: 1000),
                    tabBackgroundColor: Theme.of(context).primaryColor,
                    color: Theme.of(context).primaryColor,
                    tabs: [
                      GButton(
                        key: Key('nav_home_button'),
                        icon: Icons.home,
                        text: 'Home',
                      ),
                      GButton(
                        key: Key('nav_calendar_button'),
                        icon: Icons.calendar_today,
                        text: 'Calendar',
                      ),
                      GButton(
                        key: Key('nav_map_button'),
                        icon: Icons.map,
                        text: 'Map',
                      ),
                      GButton(
                        key: Key('nav_profile_button'),
                        icon: Icons.person,
                        text: 'Profile',
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
            children: _layoutPages(),
            onPageChanged: (index) => _setNavIndices(index),
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

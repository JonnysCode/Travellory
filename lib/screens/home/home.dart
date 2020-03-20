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
  static final _pageController = PageController(
    initialPage: 0,
  );

  int _prevSelectedIndex = 0;
  int _navBarIndex = 0;

  List<Widget> _layoutPages(){
    List<Widget> layoutPages = List();
    List<Widget> _pages = [
      HomePage(),
      CalendarPage(),
      MapPage(),
      ProfilePage()
    ];

    for(Widget page in _pages){
      layoutPages.add(mainPageLayout(context, (MediaQuery.of(context).size.height - _heightOfNavBar), page));
    }
    return layoutPages;
  }

  Widget _navigationBar(){
      return DecoratedBox(
        key: Key('nav_bar'),
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
                    onTabChange: (index) {
                      setState(() {
                        _navBarIndex = index;
                      });
                    }),
              ),
            ),
          ),
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    if(_pageController.hasClients){
      _pageController.animateToPage(
          _navBarIndex,
          duration: Duration(milliseconds: 1000),
          curve: Curves.ease
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: _layoutPages(),
        onPageChanged: (index) {
          if(_navBarIndex > _prevSelectedIndex){
            _prevSelectedIndex++;
          } else if (_navBarIndex < _prevSelectedIndex){
            _prevSelectedIndex--;
          } else {
            setState(() {
              _prevSelectedIndex = index;
              _navBarIndex = index;
            });
          }
        },
      ),
      bottomNavigationBar: _navigationBar(),
    );
  }

}

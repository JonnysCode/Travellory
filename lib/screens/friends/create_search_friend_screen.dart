import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchFriendsPage extends StatefulWidget {
  @override
  _SearchFriendsPageState createState() => _SearchFriendsPageState();
}

class _SearchFriendsPageState extends State<SearchFriendsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          key: Key('search_friends'),
          child: Stack(children: <Widget>[
            SizedBox.expand(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(6, 40, 6, 0),
                    child: Container(
                        alignment: AlignmentDirectional(-1, -1),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(40.0)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 20,
                                color: Colors.black.withOpacity(.2),
                                offset: Offset(0.0, -6.0))
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(40.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 20,
                                  color: Colors.black.withOpacity(.2),
                                  offset: Offset(0.0, -6.0))
                            ],
                          ),
                          constraints: BoxConstraints(
                            maxHeight: 90.0,
                            maxWidth: 365.0,
                          ),
                          child: //Row(children: [
                           /* IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: FaIcon(FontAwesomeIcons.arrowAltCircleLeft),
                              iconSize: 30,
                              color: Colors.red,
                            ),*/
                            SearchBar(
                              searchBarPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              headerPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              listPadding: EdgeInsets.symmetric(horizontal: 10),
                            ),

                        ))))
          ])),
    );
  }
}

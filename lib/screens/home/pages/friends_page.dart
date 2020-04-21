import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/widgets/font_widgets.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  bool _isSearching;

  @override
  void initState() {
    super.initState();
    _isSearching = false;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        key: Key('friends_page'),
        child: Stack(children: <Widget>[
          SizedBox.expand(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(6, 40, 6, 0),
                  child: Container(
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
                      child: Column(children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 40, right: 25),
                            child: _isSearching
                                ? Container() // TODO add friend page, and set state to false,
                                : Container(
                              height: 56,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    width: 160,
                                    child: FashionFetishText(
                                      text: 'Friends',
                                      size: 22,
                                      height: 1.15,
                                      fontWeight: FashionFontWeight.heavy,
                                    ),
                                  ),
                                  Positioned(
                                    top: 24,
                                    right: 36,
                                    child: FashionFetishText(
                                      text: 'Add Friends',
                                      size: 16,
                                      color: Colors.black54,
                                      fontWeight: FashionFontWeight.bold,
                                    ),
                                  ),
                                  Positioned(
                                    top: 11,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () =>{
                                        setState((){
                                          _isSearching = true;
                                        })
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.search,
                                        color: Theme.of(context).primaryColor,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        )
                      ]
                      )
                  )
              )
          )
        ]
        )
    );
  }
}

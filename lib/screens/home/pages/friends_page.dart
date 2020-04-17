import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/widgets/buttons/buttons.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 40, 6, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
                  boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.2), offset: Offset(0.0, -6.0))],
                ),
                child: Column(
                  key: Key('friends_page'),
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      'FRIENDS',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      key: Key('friend_requests'),
                      padding: EdgeInsets.only(
                          top: 10,
                          left: 30,
                          right: 90,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          'Friend requests',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      key: Key('friend_requests_list'),
                      padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                top : 10
                              ),
                              child: Text(
                                'John Doe                 acc_btn    dec_btn',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top : 15,
                                bottom: 25,
                              ),
                              child: Text(
                                'John Doe                 acc_btn    dec_btn',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),



                    Padding(
                      key: Key('my_friends'),
                      padding: EdgeInsets.only(
                          top: 10,
                          left: 30,
                          right: 90,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          'Friends',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),


                    Padding(
                      key: Key('my_friends_list'),
                      padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top : 10
                              ),
                              child: Text(
                                'Severin Schindler              remove_btn',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top : 15,
                              ),
                              child: Text(
                                'Gian Hess                           remove_btn',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top : 15,
                              ),
                              child: Text(
                                'Jöni Gruss                          remove_btn',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top : 15,
                                bottom: 25,
                              ),
                              child: Text(
                                'Benjamin Bertalan            remove_btn',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),

                    SizedBox(height: 20,),
                    Padding(
                      key: Key('add_friends'),
                      padding: EdgeInsets.only(
                          top: 10,
                          left: 90,
                          right: 90,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: filledButton("Add friends", Colors.white, Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor, Colors.white, () {
                              //TODO: fluetfab redirect to adding friends site (schinsev)
                              Navigator.pushNamed(context, '');
                            }),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 30,
            child: Icon(
              FontAwesomeIcons.addressBook,
              size: 50,
            ),
          )
        ],
      ),
    );
  }
}

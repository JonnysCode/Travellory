import 'package:flutter/material.dart';
import 'package:travellory/screens/authenticate/authenticate.dart';
import 'package:travellory/shared/loading.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/screens/authenticate/sign_in_register_option_sheet.dart';

class HomeTest extends StatefulWidget {
  @override
  HomeTestState createState() => HomeTestState();
}

class HomeTestState extends State<HomeTest> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void initState() {
      super.initState();
    }

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            Padding(
              child: Container(
                child: Center(
                  child: Text(
                      'Travel?',
                    style: TextStyle(
                      fontSize: 64,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              padding: const EdgeInsets.only(top: 300),
            ),
            Padding(
              child: Container(
                child: filledButton("LORY", Colors.white, Colors.deepOrange, Theme.of(context).accentColor,
                    Colors.white, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Authenticate()),
                      );
                    }),
                height: 50,
              ),
              padding: const EdgeInsets.only(top: 60, left: 120, right: 120),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ));
  }
}
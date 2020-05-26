import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingLogo extends StatelessWidget {
  static const route = '/loadingLogo';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login/gradient_bg.png'),
          fit: BoxFit.fill
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: -7,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/login/beach-01.png'),
                    fit: BoxFit.fitWidth
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 375,
            left: 10,
            right: 0,
            child: SpinKitRipple(
              color: Colors.green,
              size: 220.0,
            ),
          ),
          Positioned(
            bottom: 350,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo/logo_splash.png'),
                    fit: BoxFit.fitHeight
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
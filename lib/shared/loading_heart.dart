import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingHeart extends StatelessWidget {
  static const route = '/loadingHeart';

  @override
  Widget build(BuildContext context) {
    Color color = ModalRoute.of(context).settings.arguments;

    return Container(
      color: color ?? Colors.white,
      child: Center(
        child: SpinKitPumpingHeart(
          color: Colors.redAccent,
          size: 50.0,
        ),
      ),
    );
  }
}
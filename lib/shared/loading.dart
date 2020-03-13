import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitPumpingHeart(
          color: Colors.redAccent,
          size: 50.0,
        ),
      ),
    );
  }
}

// Provides a static bool to update whether your page is loading or not.
// If isLoading() is true, display the Loading() Widget instead of a Scaffold()
class LoadingState{
  static var _isLoading = false;

  static makeLoading(bool val){
    _isLoading = val;
  }

  static bool isLoading(){
    return _isLoading;
  }
}
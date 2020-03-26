import 'package:flutter/material.dart';

enum FashionFontWeight {
  LIGHT, NORMAL, BOLD, HEAVY
}

class FashionFetishText extends StatelessWidget {
  final String text;
  final double size;
  final FashionFontWeight fontWeight;
  final Color color;
  final double height;

  FashionFetishText({
    @required this.text,
    @required this.size,
    this.fontWeight,
    this.color,
    this.height,
  });

  FontWeight _getFontWeight(){
    switch(fontWeight){
      case FashionFontWeight.LIGHT:
        return FontWeight.w200;
      case FashionFontWeight.BOLD :
        return FontWeight.w600;
      case FashionFontWeight.HEAVY :
        return FontWeight.w900;
      default :
        return FontWeight.normal;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'FashionFetish',
        fontWeight: _getFontWeight(),
        fontSize: size,
        color: color,
        height: height,
        letterSpacing: size < 20 ? -1.0 : -2.0,
      ),
    );
  }
}

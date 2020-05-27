import 'package:flutter/material.dart';
import 'font_widgets.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(
      {Key key, this.sectionTitle})
      : super(key: key);

  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('SectionTitle'),
      height: 40,
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Color(0xFFCCD7DD),
      ),
      child: Row(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 12.0, right: 30.0, bottom: 7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FashionFetishText(
                  text: sectionTitle,
                  size: 15.0,
                  fontWeight: FashionFontWeight.bold,
                  color: Colors.black54),
            ],
          ),
        ),
      ]),
    );
  }
}

class BookingSiteTitle extends StatelessWidget {
  const BookingSiteTitle(
  {Key key, this.siteTitle, this.icon})
  : super(key:key);

  final String siteTitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: Key('BookingSiteTitle'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        Container(
            padding: const EdgeInsets.all(8.0),
            child: FashionFetishText(
              text: siteTitle,
              size: 24,
              fontWeight: FashionFontWeight.heavy,
              height: 1.05,
            )),
      ],
    );
  }
}

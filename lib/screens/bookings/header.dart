import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/widgets/font_widgets.dart';

Container getBookingHeader(BuildContext context, TripModel tripModel) {
  return Container(
    height: 190,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
      color: Color(0xFFCCD7DD),
    ),
    child: Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: FaIcon(FontAwesomeIcons.times),
            iconSize: 26,
            color: Colors.red,
          ),
        ),
        Positioned(
          top: -30,
          left: -40,
          child: Hero(
            tag: 'trip_image${tripModel.index.toString()}',
            child: Container(
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(tripModel.imagePath),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 180,
          child: Container(
            padding: EdgeInsets.only(top: 40, left: 10, right: 10),
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width,
            constraints:
                BoxConstraints(maxHeight: 100.0, maxWidth: MediaQuery.of(context).size.width - 200),
            child: FashionFetishText(
              text: tripModel.name,
              size: 24,
              fontWeight: FashionFontWeight.heavy,
              height: 1.05,
            ),
          ),
        ),
        Positioned(
          top: 110,
          left: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FashionFetishText(
                  text: 'From: ${toShortenedMonthDateFrom(tripModel.startDate)}' +
                      '\n' +
                      'To: ${toShortenedMonthDateFrom(tripModel.endDate)}',
                  color: Colors.black54,
                  fontWeight: FashionFontWeight.bold,
                  size: 14,
                  height: 1.25),
              SizedBox(
                height: 12,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.locationArrow,
                    size: 15,
                    color: Colors.redAccent,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 3),
                    child: FashionFetishText(
                      text: tripModel.destination,
                      size: 14,
                      fontWeight: FashionFontWeight.heavy,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

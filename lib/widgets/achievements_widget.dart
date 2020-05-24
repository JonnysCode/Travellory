import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/progress_bar/gf_progress_bar.dart';
import 'package:travellory/widgets/bookings/view_booking_header.dart';
import 'package:travellory/widgets/font_widgets.dart';

@override
Widget achievementsWidget({BookingHeader bookingHeader, @required BuildContext context, @required List<String> entries, @required List<int> percentages}) {
  return Column(children: [
    Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
    for (int i = 0; i < entries.length; i++)
      Container(
        key: Key(entries[i]),
        height: 86,
        child: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(children: <Widget>[
              SizedBox(height: 20),
              FashionFetishText(
                text: entries[i],
                size: 16,
                fontWeight: FashionFontWeight.heavy,
              ),
              SizedBox(height: 10),
              GFProgressBar(
                percentage: percentages[i] / 100,
                backgroundColor: Colors.black26,
                progressBarColor: Theme.of(context).primaryColor,
                width: MediaQuery.of(context).size.width - 86,
                lineHeight: 40.0,
                child: Padding(
                  padding: EdgeInsets.only(top: 7),
                  child: Text(
                    '${percentages[i]}%',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
            ]),
          )
        ]
        ),
      )
  ]);
}
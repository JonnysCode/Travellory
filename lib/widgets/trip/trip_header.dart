import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/screens/trip/create_trip_screen.dart';
import 'package:travellory/utils/date_handler.dart';
import 'package:travellory/widgets/bookings/edit.dart';
import 'package:travellory/widgets/font_widgets.dart';

class TripHeader extends StatefulWidget {
  const TripHeader(this.tripModel, {Key key}) : super(key: key);

  final TripModel tripModel;

  @override
  _TripHeaderState createState() => _TripHeaderState();
}

class _TripHeaderState extends State<TripHeader> {
  TripModel _tripModel;

  @override
  Widget build(BuildContext context) {
    _tripModel = widget.tripModel;

    return Container(
      key: Key('TripHeader'),
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
              tag: 'trip_image${_tripModel.index.toString()}',
              child: Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_tripModel.imagePath),
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
              constraints: BoxConstraints(
                  maxHeight: 100.0, maxWidth: MediaQuery.of(context).size.width - 200),
              child: Text(
                _tripModel.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontFamily: 'FashionFetish',
                    fontSize: 22,
                    height: 1.1,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 190,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FashionFetishText(
                    text: 'From: ${dMMMyyyy(getDateTimeFrom(_tripModel.startDate))}\n'
                        'To: ${dMMMyyyy(getDateTimeFrom(_tripModel.endDate))}',
                    color: Colors.black54,
                    fontWeight: FashionFontWeight.bold,
                    size: 14,
                    height: 1.25),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.locationArrow,
                      size: 15,
                      color: Colors.redAccent,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    SizedBox(
                      width: 160,
                      child: Text(
                        _tripModel.destination,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: 'FashionFetish',
                            fontSize: 13,
                            height: 1.15,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                            color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 125,
            left: 330,
            right: 10,
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CreateTrip.route,
                    arguments: ModifyModelArguments(model: widget.tripModel, isNewModel: false));
              },
              icon: Icon(
                FontAwesomeIcons.edit,
                size: 25.0,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

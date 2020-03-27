import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/widgets/font_widgets.dart';

class TripCard extends StatefulWidget {
  final TripModel tripModel;

  const TripCard({
    Key key,
    @required this.tripModel
  }) : super(key: key);

  @override
  _TripCardState createState() => _TripCardState(tripModel);
}

class _TripCardState extends State<TripCard> {
  TripModel _tripModel;

  _TripCardState(TripModel tripModel){
    _tripModel = tripModel;
  }

  void _openTrip(){
    Navigator.pushReplacementNamed(context, '/viewtrip', arguments: _tripModel);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(.15), offset: Offset(3.0, 3.0))],
      ),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => _openTrip(),
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color(0xFFCCD7DD),
              ),
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: 'trip_image' + _tripModel.index.toString(),
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_tripModel.imagePath),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 12.0, right: 30.0, bottom: 7.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FashionFetishText(
                          text: _tripModel.name,
                          size: 20.0,
                          fontWeight: FashionFontWeight.HEAVY,
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        FashionFetishText(
                          text: DateConverter.toShortenedMonthString( _tripModel.startDate)
                            + ' - '
                            + DateConverter.toShortenedMonthString( _tripModel.endDate),
                          size: 14.0,
                          fontWeight: FashionFontWeight.BOLD,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.locationArrow,
                                size: 15,
                                color: Colors.redAccent,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6, left: 3),
                                child: FashionFetishText(
                                  text: _tripModel.destination,
                                  size: 14.0,
                                  fontWeight: FashionFontWeight.HEAVY,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 90,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                  onPressed: () => _openTrip(),
                  icon: FaIcon(FontAwesomeIcons.angleDown, color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

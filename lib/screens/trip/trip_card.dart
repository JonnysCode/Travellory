import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/widgets/font_widgets.dart';

class TripCard extends StatefulWidget {
  const TripCard({
    @required this.tripModel,
    Key key,
  }) : super(key: key);

  final TripModel tripModel;

  @override
  _TripCardState createState() => _TripCardState(tripModel);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties){
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TripModel>('tripModel', tripModel));
  }
}

class _TripCardState extends State<TripCard> {
  TripModel _tripModel;

  _TripCardState(TripModel tripModel){
    _tripModel = tripModel;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 40,
            right: 0,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/viewtrip', arguments: _tripModel),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xBBCCD7DD),
                  boxShadow: <BoxShadow>[
                    //BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(.2), offset: Offset(3.0, 3.0))
                  ]
                ),
                padding: const EdgeInsets.only(left: 50.0, top: 14.0, bottom: 14.0, right: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FashionFetishText(
                      text: _tripModel.name,
                      size: 18.0,
                      fontWeight: FashionFontWeight.HEAVY,
                      height: 1.1,
                    ),
                    Spacer(),
                    FashionFetishText(
                      text: '${DateConverter.format( _tripModel.startDate)} - '
                          + '${DateConverter.format( _tripModel.endDate)}',
                      size: 14.0,
                      fontWeight: FashionFontWeight.BOLD,
                      color: Colors.black54,
                      height: 1.3,
                    ),
                    Spacer(),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.locationArrow,
                          size: 14,
                          color: Colors.redAccent,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6, left: 3),
                          child: FashionFetishText(
                            text: _tripModel.destination,
                            size: 13.0,
                            fontWeight: FashionFontWeight.HEAVY,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Hero(
              tag: 'trip_image${_tripModel.index.toString()}',
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: <BoxShadow>[
                    BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(.3), offset: Offset(3.0, 3.0))
                  ],
                  image: DecorationImage(
                    image: AssetImage(_tripModel.imagePath),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

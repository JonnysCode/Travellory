import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/widgets/bookings/edit_delete_dialogs.dart';
import 'package:travellory/widgets/buttons/option_button.dart';
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
  _TripCardState(TripModel tripModel){
    _tripModel = tripModel;
    _deleteAlertText = 'You are about to delete the '
        'trip \" ${tripModel.name} \" and all its bookings. '
        'Are you sure you want to continue? This action cannot be undone!';
  }
  TripModel _tripModel;
  String _deleteAlertText;


  void _openTrip(){
    Provider.of<TripsProvider>(context, listen: false).selectTrip(_tripModel);
    Navigator.pushNamed(context, '/viewtrip');
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
              onTap: () => _openTrip(),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xBBCCD7DD),
                ),
                padding: const EdgeInsets.only(left: 50.0, top: 14.0, bottom: 14.0, right: 14.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                            child: Text(
                              _tripModel.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: 'FashionFetish',
                                  fontSize: 18,
                                  height: 1.1,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -1
                              ),
                            ),
                          ),
                          Spacer(),
                          FashionFetishText(
                            text: '${dMMMyyyy(getDateTimeFrom(_tripModel.startDate))} - '
                                  '${dMMMyyyy(getDateTimeFrom(_tripModel.endDate))}',
                            size: 14.0,
                            fontWeight: FashionFontWeight.bold,
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
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 6, left: 3),
                                  child: Text(
                                    _tripModel.destination,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: 'FashionFetish',
                                      fontSize: 13,
                                      height: 1.2,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black54,
                                      letterSpacing: -1
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    OptionButton(
                      optionItems: <OptionItem>[
                        OptionItem(
                          description: 'Edit',
                          icon: FontAwesomeIcons.edit,
                          onTab: () {}
                        ),
                        OptionItem(
                            description: 'Remove',
                            icon: FontAwesomeIcons.trashAlt,
                            color: Colors.redAccent,
                            onTab: () => showDeleteDialog(_tripModel, context, _deleteAlertText)
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



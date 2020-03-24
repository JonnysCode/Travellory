import 'package:flutter/material.dart';
import 'package:travellory/models/trip_model.dart';

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
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Color(0xFFCCD7DD),
            ),
            child: Row(
              children: <Widget>[
                Hero(
                  tag: 'trip_image',
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
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        _tripModel.name,
                        style: TextStyle(
                          fontFamily: 'FashionFetish',
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          letterSpacing: -2.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Text(
                        _tripModel.startDate.toString().substring(0, 10)
                            + ' - '
                            + _tripModel.endDate.toString().substring(0, 10),
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'FashionFetish',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          letterSpacing: -2.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.redAccent,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              _tripModel.destination,
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'FashionFetish',
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                                letterSpacing: -1.0,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: FlatButton.icon(
                  onPressed: () => { Navigator.pushReplacementNamed(context, '/viewtrip') },
                  icon: Icon(Icons.open_in_new, color: Colors.black54),
                  label: Text('')
              ),
            ),
          )
        ],
      ),
    );
  }
}

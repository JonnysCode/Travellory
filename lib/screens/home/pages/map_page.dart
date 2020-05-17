import 'dart:async';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/screens/bookings/view_accommodation.dart';
import 'package:travellory/utils/g_map/g_map_border_loader.dart';

String _mapStyle;
// ["switzerland", "austria", "belgium"]
final List<String> _userStates = List<String>();

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/g_map/map_style.json').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
        child: Container(
          key: Key('map_page'),
          child: MapSample(),
        ),
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
  final GMapBorderLoader _gMapBorderLoader = GMapBorderLoader();
  final Map<String, Marker> _markers = {};
  final List<Polygon> _boundaries = [];

  Future<void> loadAccommodations() async {
    final List<SingleTripProvider> trips =
        Provider.of<TripsProvider>(context, listen: false).trips;

    _markers.clear();

    for (final SingleTripProvider trip in trips) {
      final List<AccommodationModel> accommodations = trip.accommodations;

      if(!_userStates.contains(trip.tripModel.country)){
        _userStates.add(trip.tripModel.country);
      }

      //print(trip.tripModel.country);

      for (final AccommodationModel accommodation in accommodations) {
        final marker = Marker(
          markerId: MarkerId(accommodation.name),
          position: LatLng(accommodation.latitude, accommodation.longitude),
          infoWindow: InfoWindow(
              title: accommodation.name,
              snippet: accommodation.address,
              onTap: () {
                Navigator.pushNamed(context, AccommodationView.route, arguments: accommodation);
              }),
        );
        _markers[accommodation.tripUID] = marker;
      }
    }
  }

  Future<void> onMapCreated() async {
    final _boundariesTemp = await _gMapBorderLoader.generateBorders(_userStates);

    setState(() {
      loadAccommodations();

      if (_boundariesTemp.isNotEmpty) {
        _boundaries.clear();
        _boundariesTemp.forEach(_boundaries.add);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
        GoogleMap(
          key: Key('google_map_widget'),
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(46.8076885, 7.1005233),
            zoom: 5,
          ),
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          ].toSet(),
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(_mapStyle);
            onMapCreated();
            _controller.complete(controller);
          },
          markers: _markers.values.toSet(),
          polygons: _boundaries.toSet(),
        ),
        FabCircularMenu(
            key: Key('FabCircularMenu'),
            ringColor: Colors.black38,
            ringWidth: 50.0,
            ringDiameter: 220.0,
            fabColor: Theme.of(context).accentColor,
            fabOpenIcon: Icon(
              FontAwesomeIcons.bars,
              color: Colors.white,
            ),
            fabCloseIcon: Icon(
              FontAwesomeIcons.times,
              color: Colors.white,
            ),
            fabMargin: EdgeInsets.only(right: 20.0, bottom: 70),
            alignment: Alignment.bottomRight,
            children: <Widget>[
              IconButton(
                  icon: Icon(FontAwesomeIcons.home),
                  color: Colors.white,
                  onPressed: () {
                  }),
              IconButton(
                  icon: Icon(FontAwesomeIcons.plane),
                  color: Colors.white,
                  onPressed: () {
                  }),
              IconButton(
                  icon: Icon(FontAwesomeIcons.theaterMasks),
                  color: Colors.white,
                  onPressed: () {
                  }),
              IconButton(
                  icon: Icon(FontAwesomeIcons.bed),
                  color: Colors.white,
                  onPressed: () {
                  }),
            ]
        ),
      ]
    );
  }
}

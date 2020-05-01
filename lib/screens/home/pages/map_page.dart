import 'dart:async';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/screens/bookings/view_accommodation.dart';
import 'package:travellory/utils/g_map/g_map_border_loader.dart';
import 'package:travellory/widgets/trip/trip_card.dart';

String _mapStyle;
final List<String> _userStates = ["switzerland","austria","belgium"];

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
  final Map<String, Marker> _markers = {};
  final List<Polygon> _boundaries = [];

  Future<void> test() async {
    final List<SingleTripProvider> trips = await Provider.of<TripsProvider>(context, listen: false).trips;

    _markers.clear();

    for (final SingleTripProvider trip in trips) {
      await trip.tripModel.init();
      final List<AccommodationModel> accommodations = await trip.accommodations;

      for (final AccommodationModel accommodation in accommodations) {
        final marker = Marker(
          markerId: MarkerId(accommodation.name),
          position: LatLng(accommodation.latitude, accommodation.longitude),
          infoWindow: InfoWindow(
            title: accommodation.name,
            snippet: accommodation.address,
            onTap: () {
              AccommodationView();
            }
          ),
        );
        _markers[accommodation.tripUID] = marker;
      }
    }
  }

  Future<void> onMapCreated() async {
    //final googleOffices = await locations.getGoogleOffices();
    final _boundariesTemp = await GMapBorderLoader.generateBorders(_userStates);

    setState(() {
      /*
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          /*
          onTap: () {
            // TODO: open location info page
          },
          */
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
       */

      test();

      if(_boundariesTemp.isNotEmpty){
        _boundaries.clear();
        _boundariesTemp.forEach(_boundaries.add);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
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
        Positioned(
          child: FabCircularMenu(
              alignment: Alignment.topRight,
              children: <Widget>[
                IconButton(icon: Icon(Icons.home), onPressed: () {
                  print('Home');
                }),
                IconButton(icon: Icon(Icons.favorite), onPressed: () {
                  print('Favorite');
                })
              ]
          ),
        )
      ],
    );
  }
}

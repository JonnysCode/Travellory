import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travellory/utils/g_map/g_map_border_loader.dart';
import 'package:travellory/services/api/map/locations.dart' as locations;

String _mapStyle;
final List<String> _userCities = ["switzerland"];

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
        padding: const EdgeInsets.fromLTRB(6, 12, 6, 0),
        child: Container(
          key: Key('map_page'),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            child: MapSample()
          ),
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

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  Future<void> _loadCitiesBoundaries(GoogleMapController controller) async {
    final boundaries = await GMapBorderLoader.generateBorders(_userCities);
    setState(() {
      _boundaries.clear();
      if(boundaries.isNotEmpty){
        boundaries.forEach((final element) => _boundaries.add(element));
      }
    });
  }

  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(46.8076885, 7.1005233),
    zoom: 5,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            key: Key('google_map_widget'),
            mapType: MapType.normal,
            initialCameraPosition: _initialCameraPosition,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            ].toSet(),
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(_mapStyle);
              _onMapCreated(controller);
              _loadCitiesBoundaries(controller);
              _controller.complete(controller);
            },
            markers: _markers.values.toSet(),
            polygons: _boundaries.toSet(),
          ),
          Positioned(
            right: 10,
            bottom: 150,
            child: FloatingActionButton.extended(
              onPressed: _goToTheLake,
              label: Text('To the lake!'),
              icon: Icon(Icons.directions_boat),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

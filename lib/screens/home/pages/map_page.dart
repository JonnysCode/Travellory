import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travellory/services/api/map/locations.dart' as locations;

String _mapStyle;

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

  static final CameraPosition _kGooglePlex = CameraPosition(
    //target: LatLng(37.42796133580664, -122.085749655962),
    target: LatLng(45.521563, -122.677433),
    zoom: 5,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          key: Key('google_map_widget'),
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          ].toSet(),
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(_mapStyle);
            _onMapCreated(controller);
            _controller.complete(controller);
          },
          markers: _markers.values.toSet(),
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
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

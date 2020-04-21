import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travellory/utils/g_map/g_map_border_loader.dart';
import 'package:travellory/services/api/map/locations.dart' as locations;

String _mapStyle;
final List<String> _userCities = ["switzerland","germany","belgium"]; // TODO: change to user real visited cities
final Completer<GoogleMapController> g_controller = Completer();
final Map<String, Marker> markers = {};
final List<Polygon> boundaries = [];

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

  Future<void> onMapCreated() async {
    final googleOffices = await locations.getGoogleOffices();
    final t_boundaries = await GMapBorderLoader.generateBorders(_userCities);
    setState(() {
      markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        markers[office.name] = marker;
      }

      if(t_boundaries.isNotEmpty){
        boundaries.clear();
        for (final boundary in t_boundaries){
          boundaries.add(boundary);
        }
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
            g_controller.complete(controller);
          },
          markers: markers.values.toSet(),
          polygons: boundaries.toSet(),
        ),
      ],
    );
  }
}


import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapBorderLoader{
  static List<Polygon> _borders;

  static Future<List<LatLng>> _doPoints(String city_name) async {
    List<LatLng> points = [];

    String data = await rootBundle.loadString('assets/g_map/border_points/switzerland.json');
    final jsonResult = json.decode(data);
    List result = jsonResult["geometry"] as List;

    result.forEach((element) => points.add(LatLng(element[0],element[1])));

    return points;
  }

  static Future<void> _doPolygon(String city_name) async {
    _borders.add(
        Polygon(
        polygonId: PolygonId(city_name),
        consumeTapEvents: false,
        fillColor: Color.fromRGBO(255, 0, 0, 0.35),
        geodesic: false,
        points: await _doPoints(city_name),
        strokeColor: Color.fromRGBO(255, 0, 0, 0.8),
        strokeWidth: 2,
        visible: true,
        zIndex: 0,
        //onTap: (){print("Tapped!");},
      )
    );
  }

  static Future<List<Polygon>> generateBorders (List<String> cities) async {
    cities.forEach((city_name) => _doPolygon(city_name));
    return _borders;
  }
}

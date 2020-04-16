
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapBorderLoader{
  static final List<Polygon> _borders = List<Polygon>();

  static Future<List<LatLng>> _doPoints(String city_name) async {
    final List<LatLng> points = List<LatLng>();

    String data = await rootBundle.loadString('assets/g_map/border_points/switzerland.json');
    final jsonResult = await json.decode(data);
    List results = jsonResult["geometry"] as List;
    for(var result in results) {
      points.add(LatLng(result[0],result[1]));
    }

    return points;
  }

  static Future<void> _doPolygon(String city_name) async {
    final points = await _doPoints(city_name);
    _borders.add(
        Polygon(
        polygonId: PolygonId(city_name),
        consumeTapEvents: false,
        fillColor: Color.fromRGBO(255, 0, 0, 0.35),
        geodesic: false,
        points: points,
        strokeColor: Color.fromRGBO(255, 0, 0, 0.8),
        strokeWidth: 2,
        visible: true,
        zIndex: 0,
        //onTap: (){print("Tapped!");},
      )
    );
  }

  static Future<List<Polygon>> generateBorders (List<String> cities) async {
    _borders.clear();
    for(var city_name in cities) {
      await _doPolygon(city_name);
    }
    return _borders;
  }
}

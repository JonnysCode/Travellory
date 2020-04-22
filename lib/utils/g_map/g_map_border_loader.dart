
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapBorderLoader{
  @visibleForTesting
  static Future<List<LatLng>> doPoints(String city_name) async {
    final List<LatLng> points = List<LatLng>();

    String data = await rootBundle.loadString('assets/g_map/border_points/'+city_name.toLowerCase()+'.json');
    final jsonResult = await json.decode(data);
    List results = jsonResult["geometry"] as List;
    for(var result in results) {
      points.add(LatLng(result[0].toDouble(),result[1].toDouble()));
    }

    return points;
  }

  @visibleForTesting
  static Future<Polygon> doPolygon(String city_name) async {
    final points = await doPoints(city_name);
    return Polygon(
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
    );
  }

  static Future<List<Polygon>> generateBorders (List<String> cities) async {
    final List<Polygon> borders = List<Polygon>();

    for(var city_name in cities) {
      borders.add(await doPolygon(city_name));
    }
    return borders;
  }
}
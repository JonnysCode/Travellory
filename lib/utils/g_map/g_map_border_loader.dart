
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapBorderLoader{
  @visibleForTesting
  static Future<List<LatLng>> doPoints(String cityName) async {
    final List<LatLng> points = <LatLng>[];

    String data = await rootBundle.loadString('assets/g_map/border_points/${cityName.toLowerCase()}.json');
    final jsonResult = await json.decode(data);
    List results = jsonResult["geometry"] as List;
    for(var result in results) {
      points.add(LatLng(result[0].toDouble(),result[1].toDouble()));
    }

    return points;
  }

  @visibleForTesting
  static Future<Polygon> doPolygon(String cityName) async {
    final points = await doPoints(cityName);
    return Polygon(
      polygonId: PolygonId(cityName),
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
    final List<Polygon> borders = <Polygon>[];

    for(var city_name in cities) {
      borders.add(await doPolygon(city_name));
    }
    return borders;
  }
}

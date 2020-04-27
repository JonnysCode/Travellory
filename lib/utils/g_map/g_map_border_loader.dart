
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapBorderLoader{
  static String data;

  @visibleForTesting
  static Future<List<LatLng>> doPoints(String stateName) async {
    final List<LatLng> points = <LatLng>[];

    try {
      data = await rootBundle.loadString('assets/g_map/border_points/${stateName.toLowerCase()}.json');
    }catch(_){
      return points;
    }

    final jsonResult = await json.decode(data);
    final List results = jsonResult["geometry"] as List;
    for(final result in results) {
      points.add(LatLng(result[0].toDouble(),result[1].toDouble()));
    }

    return points;
  }

  @visibleForTesting
  static Future<Polygon> doPolygon(String stateName) async {
    final points = await doPoints(stateName);
    return Polygon(
      polygonId: PolygonId(stateName),
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

  static Future<List<Polygon>> generateBorders (List<String> states) async {
    final List<Polygon> borders = <Polygon>[];

    for(final stateName in states) {
      final Polygon state = await doPolygon(stateName);
      if(state.points.isNotEmpty){
        borders.add(state);
      }
    }
    return borders;
  }
}

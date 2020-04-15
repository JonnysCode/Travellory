import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapBorderLoader{
  static List<Polygon> _borders;

  static List<LatLng> _doPoints(String city_name){
    List<LatLng> points;

    return points;
  }

  static void _doPolygon(String city_name){
    _borders.add(
        Polygon(
        polygonId: PolygonId(city_name),
        consumeTapEvents: false,
        fillColor: Color.fromRGBO(255, 0, 0, 0.35),
        geodesic: false,
        points: _doPoints(city_name),
        strokeColor: Color.fromRGBO(255, 0, 0, 0.8),
        strokeWidth: 2,
        visible: true,
        zIndex: 0,
        /*
        onTap: (){
          print("Tapped!");
        },
        */
      )
    );
  }

  static Future<List<Polygon>> generateBorders(List<String> cities) async{
    cities.forEach((city_name) => _doPolygon(city_name));
    return _borders;
  }
}
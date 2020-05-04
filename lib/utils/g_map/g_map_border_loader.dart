
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapBorderLoader{
  static String data;

  /*
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
*/




  ////////////////// OLDDDDD ABOVE!!! //////////////////////////////////////////////////////////////////////////////////////////




  static void readMultiPolygon(List multiPolygon, List<Polygon> return_polygons, String stateName) async {

    for(int i=0; i<multiPolygon.length; i++){
      final List<LatLng> points = <LatLng>[];
      for(int j=0; j<(multiPolygon[i][0] as List).length; j++){
        points.add(LatLng(multiPolygon[i][0][j][1].toDouble(),multiPolygon[i][0][j][0].toDouble()));
      }
      /*
      for(final List dots in multiPolygon[i]) {
        points.add(LatLng(dots[1].toDouble(),dots[0].toDouble()));
      }

       */
      return_polygons.add(Polygon(
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
      ));
    }

    /*
    for(final dynamic polygon in multiPolygon) {
      final List<LatLng> points = <LatLng>[];
      for(final dynamic dots in polygon[0]) {
        points.add(LatLng(dots[1].toDouble(),dots[0].toDouble()));
      }
      return_polygons.add(Polygon(
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
      ));
    }

     */
  }

  static void readPolygon(List polygon, List<Polygon> return_polygons, String stateName) async {
    final List<LatLng> points = <LatLng>[];

    for(final dynamic dots in polygon) {
      points.add(LatLng(dots[1].toDouble(),dots[0].toDouble()));
    }

    return_polygons.add(Polygon(
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
    ));
  }


  static Future<List<Polygon>> fetchPolygons(String stateName) async {
    final List<Polygon> polygons = <Polygon>[];

    try {
      data = await rootBundle.loadString('assets/g_map/border_points/${stateName.toLowerCase()}.json');
    }catch(_){
      return polygons;
    }

    final Map jsonResult = await json.decode(data);
    //print(stateName);
    //print(jsonResult["features"][0]["geometry"]["coordinates"][0] as List);


    switch (jsonResult["features"][0]["geometry"]["type"]){
      case "Polygon":
        await readPolygon(jsonResult["features"][0]["geometry"]["coordinates"][0] as List, polygons, stateName);
        break;
      case "MultiPolygon":
        await readMultiPolygon(jsonResult["features"][0]["geometry"]["coordinates"] as List, polygons, stateName);
        break;
      default:
        return polygons;
        break;
    }



    return polygons;
  }



  static Future<List<Polygon>> generateBorders (List<String> states) async {

    final List<Polygon> borders = <Polygon>[];

/*
    for(final stateName in states) {
      final Polygon state = await doPolygon(stateName);
      if(state.points.isNotEmpty){
        borders.add(state);
      }
    }
    return borders;
    */

    for(final stateName in states) {
      final List<Polygon> state = await fetchPolygons(stateName);
      if(state.isNotEmpty){
        await state.forEach(borders.add);
      }
    }

    return borders;
  }
}

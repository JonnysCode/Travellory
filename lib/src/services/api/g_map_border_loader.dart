import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapBorderLoader{
  void readMultiPolygon(List multiPolygon, List<Polygon> returnPolygons, String stateName) async {

    for(int i=0; i<multiPolygon.length; i++){
      final List<LatLng> points = <LatLng>[];
      for(int j=0; j<(multiPolygon[i][0] as List).length; j++){
        points.add(LatLng(multiPolygon[i][0][j][1].toDouble(),multiPolygon[i][0][j][0].toDouble()));
      }
      returnPolygons.add(Polygon(
        polygonId: PolygonId('${stateName}_${i.toString()}'),
        consumeTapEvents: false,
        fillColor: Color.fromRGBO(255, 0, 0, 0.35),
        geodesic: false,
        points: points,
        strokeColor: Color.fromRGBO(255, 0, 0, 0.8),
        strokeWidth: 2,
        visible: true,
        zIndex: 0,
      ));
    }
  }

  void readPolygon(List polygon, List<Polygon> returnPolygons, String stateName) async {
    final List<LatLng> points = <LatLng>[];

    for(final dynamic dots in polygon) {
      points.add(LatLng(dots[1].toDouble(),dots[0].toDouble()));
    }

    returnPolygons.add(Polygon(
      polygonId: PolygonId(stateName),
      consumeTapEvents: false,
      fillColor: Color.fromRGBO(255, 0, 0, 0.35),
      geodesic: false,
      points: points,
      strokeColor: Color.fromRGBO(255, 0, 0, 0.8),
      strokeWidth: 2,
      visible: true,
      zIndex: 0,
    ));
  }


  Future<List<Polygon>> fetchPolygons(String stateName) async {
    String data;
    final List<Polygon> polygons = <Polygon>[];

    try {
      data = await rootBundle.loadString('assets/g_map/border_points/${stateName.replaceAll(" ", "_").toLowerCase()}.json');
    } on Exception catch(_){
      return polygons;
    }

    final Map jsonResult = await json.decode(data);

    switch (jsonResult["features"][0]["geometry"]["type"]){
      case "Polygon":
        readPolygon(jsonResult["features"][0]["geometry"]["coordinates"][0] as List, polygons, stateName);
        break;
      case "MultiPolygon":
        readMultiPolygon(jsonResult["features"][0]["geometry"]["coordinates"] as List, polygons, stateName);
        break;
      default:
        return polygons;
        break;
    }

    return polygons;
  }


  Future<List<Polygon>> generateBorders(List<String> states) async {

    final List<Polygon> borders = <Polygon>[];

    for(final stateName in states) {
      final List<Polygon> state = await fetchPolygons(stateName);
      if(state.isNotEmpty){
        state.forEach(borders.add);
      }
    }

    return borders;
  }
}

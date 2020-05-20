import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/utils/g_map/g_map_border_loader.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async{
  TestWidgetsFlutterBinding.ensureInitialized();

  final GMapBorderLoader _gMapBorderLoader = GMapBorderLoader();

  test('Test random single polygon', () async {
    final List<Polygon> polygons = <Polygon>[];
    List randomPolygon = [[0.8,1.9],[0.2,0.3]];
    await _gMapBorderLoader.readPolygon(randomPolygon,polygons,"state_name");

    expect(polygons[0].points.length, 2);
  });

  test('Test random multi polygon', () async {
    final List<Polygon> polygons = <Polygon>[];
    List randomPolygon = [[[[0.8,1.9],[0.2,0.3]]],[[[0.8,1.9],[0.2,0.3]]]];
    await _gMapBorderLoader.readMultiPolygon(randomPolygon,polygons,"state_name");

    expect(polygons.length, 2);
    expect(polygons[0].points.length, 2);
    expect(polygons[1].points.length, 2);
  });
}
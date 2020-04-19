import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/utils/g_map/g_map_border_loader.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async{
  TestWidgetsFlutterBinding.ensureInitialized();

  final String _state_name = "Switzerland";
  final int _n_points = 11608;

  test('Try to get switzerland borders', () async {
    List<Polygon> border = await GMapBorderLoader.generateBorders([_state_name]);

    expect(border[0].points.length, _n_points);
  });

  test('Try if right polygon gets generated', () async {
    Polygon polygon = await GMapBorderLoader.doPolygon(_state_name);

    expect(polygon.points.length, _n_points);
    expect(polygon.polygonId.value, _state_name);
  });

  test('Try to generate borders', () async {
    List<LatLng> points = await GMapBorderLoader.doPoints(_state_name);

    expect(points.length, 11608);
  });
}
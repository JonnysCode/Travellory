import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:travellory/services/api/openWeatherAPI.dart';
import 'package:travellory/utils/weather.dart';

class MockWeather extends Mock implements OpenWeatherAPI {}

var data = '{coord: {lon: 17.03, lat: 51.1}, weather: [{id: 803, main: Clouds, description: broken clouds, icon: 04n}], base: stations, main: {temp: 288.07, feels_like: 285.07, temp_min: 285.93, temp_max: 289.15, pressure: 1020, humidity: 63}, visibility: 10000, wind: {speed: 3.6, deg: 220}, clouds: {all: 70}, dt: 1589832019, sys: {type: 1, id: 1715, country: PL, sunrise: 1589770628, sunset: 1589827186}, timezone: 7200, id: 3081368, name: Wrocław, cod: 200}';

void main() {
  Widget makeTestableWidget({Widget child, OpenWeatherAPI weatherAPI}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('test if page is the weather page', (WidgetTester tester) async {
    MockWeather mockWeather = MockWeather();
    Weather page = Weather('Winterthur',mockWeather);
    when(mockWeather.getWeather('Winterthur')).thenAnswer((realInvocation) async => data);

    // Build our app and trigger a frame.
    await tester.pumpWidget(await makeTestableWidget(child: page,weatherAPI: mockWeather));

    // Verify that the weather page is present.
    expect(find.byKey(Key('weather_page')), findsOneWidget);
  });

  testWidgets('test if page has AssetImage', (WidgetTester tester) async {
    MockWeather mockWeather = MockWeather();
    Weather page = Weather('Wrocław',mockWeather);
    when(mockWeather.getWeather('Wrocław')).thenAnswer((realInvocation) async => data);

    // Build our app and trigger a frame.
    await tester.pumpWidget(await makeTestableWidget(child: page,weatherAPI: mockWeather));
    var assetImage = find.byType(Container);

    // Verify that the weather page is present.
    expect(assetImage, findsNWidgets(3));
  });



}

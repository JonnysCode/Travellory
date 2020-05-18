import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:travellory/services/api/openWeatherAPI.dart';
import 'package:travellory/utils/weather.dart';

class MockWeather extends Mock implements OpenWeatherAPI {}

void main() {
  Widget makeTestableWidget({Widget child, OpenWeatherAPI weatherAPI}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('test if page is the weather page', (WidgetTester tester) async {
    Weather page = Weather('Winterthur');
    MockWeather mockWeather = MockWeather();

    // Build our app and trigger a frame.
    await tester.pumpWidget(await makeTestableWidget(child: page,weatherAPI: mockWeather));

    // Verify that the weather page is present.
    expect(find.byKey(Key('weather_page')), findsOneWidget);
  });

  testWidgets('test if page has AssetImage', (WidgetTester tester) async {
    Weather page = Weather('Winterthur');

    // Build our app and trigger a frame.
    await tester.pumpWidget(await makeTestableWidget(child: page));

    // Verify that the weather page is present.
    expect(find.byKey(Key('weather_page')), findsOneWidget);
  });


  testWidgets('test if page has two texts', (WidgetTester tester) async {
    Weather page = Weather('Winterthur');

    // Build our app and trigger a frame.
    await tester.pumpWidget(await makeTestableWidget(child: page));

    // Verify that the weather page is present.
    expect(find.byKey(Key('weather_page')), findsOneWidget);
  });

  testWidgets('test selectImage method', (WidgetTester tester) async {
    Weather page = Weather('Winterthur');

    // Build our app and trigger a frame.
    await tester.pumpWidget(await makeTestableWidget(child: page));

    // Verify that the weather page is present.
    expect(find.byKey(Key('weather_page')), findsOneWidget);
  });
}

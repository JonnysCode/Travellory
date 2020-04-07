import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/screens/home/pages/map_page.dart';

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('test if navigation is present', (WidgetTester tester) async {
    Widget page = MapPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that map container is present.
    expect(find.byKey(Key('map_page')), findsOneWidget);

    // Verify that simple button is present.
    expect(find.byIcon(Icons.directions_boat), findsOneWidget);

    // Verify that google_map_widget is loaded
    expect(find.byKey(Key('google_map_widget')), findsOneWidget);
  });
}
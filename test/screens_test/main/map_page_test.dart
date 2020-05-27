import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/src/screens/main/map_page.dart';

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('test if map page is loading correcly', (WidgetTester tester) async {
    Widget page = MapPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that map container is present.
    expect(find.byKey(Key('map_page')), findsOneWidget);


    // Verify that google_map_widget is loaded
    expect(find.byKey(Key('google_map_widget')), findsOneWidget);
  });
}
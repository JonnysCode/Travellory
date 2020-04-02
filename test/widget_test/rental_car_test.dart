import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/screens/trip/rentalCar.dart';

import 'test_wrapper.dart';

void main() {
  Widget makeTestableWidget(){
    return MaterialApp(
      //key: Key('RentalCar'),
      routes: {
        '/': (context) => TestWrapper(),
        '/booking/rentalCar': (context) => RentalCar()
      },
    );
  }

  testWidgets('test if Rental Car page is loaded', (WidgetTester tester) async {
    final testKey = Key('Rental Car');

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    //expect(find.byType(Scaffold), findsOneWidget);
    // Verify that the RentalCar form is present.
    expect(find.byKey(testKey), findsOneWidget);

  });

  testWidgets('test if form instance is found', (WidgetTester tester) async {
   // Widget page = RentalCar();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    // verify that form is present
    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('test if form is present', (WidgetTester tester) async {
    Widget page = RentalCar();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    // Verify that form is present.
    expect(find.byType(Form), findsOneWidget);

    // Verify that all form fields are present.
    expect(find.byIcon(Icons.confirmation_number), findsOneWidget);
    expect(find.byIcon(Icons.supervised_user_circle), findsOneWidget);
    expect(find.byIcon(Icons.location_on), findsNWidgets(2));
    expect(find.byIcon(Icons.date_range), findsNWidgets(2));
    expect(find.byIcon(Icons.access_time), findsNWidgets(2));
    expect(find.byIcon(Icons.directions_car), findsNWidgets(2));
    expect(find.byIcon(Icons.speaker_notes), findsOneWidget);
  });

  testWidgets('test if submit button is present', (WidgetTester tester) async {
    Widget page = RentalCar();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    // Verify that form is present.
    expect(find.byKey(Key('SubmitButton')), findsOneWidget);
  });

  testWidgets('test if cancel button is present', (WidgetTester tester) async {
    Widget page = RentalCar();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    // Verify that form is present.
    expect(find.byKey(Key('CancelButton')), findsOneWidget);
  });

  // TODO this doesn't work yet
//  testWidgets('validate form input error message', (WidgetTester tester) async {
//    Widget page = RentalCar();
//    final inputErrorFinder = find.text('Please enter the required information');
//    final buttonFinder = find.text('SUBMIT');
//
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(makeTestableWidget(child: page));
//
//    await tester.tap(buttonFinder);
//
//    await tester.pump(const Duration(milliseconds: 1000)); // add delay
//
//    expect(inputErrorFinder, findsOneWidget);
//  });
}
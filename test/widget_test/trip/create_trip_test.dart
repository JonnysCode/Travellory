import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/screens/trip/create_trip_screen.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user_model.dart';

void main() {
  Widget makeTestableWidget({Widget page}) {
    UserModel user = UserModel(uid: 'uid', displayName: 'name');
    TripsProvider tripsProvider = TripsProvider()
      ..user = user;
    return ChangeNotifierProvider<TripsProvider>(
      create: (_) => tripsProvider,
      child: MaterialApp(
        home: page,
      ),
    );
  }

  testWidgets('test if create trip page is loaded', (WidgetTester tester) async {
    final testKey = Key('create_trip');
    Widget page = CreateTrip();

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('test if form instance is found', (WidgetTester tester) async {
    Widget page = CreateTrip();

    await tester.pumpWidget(makeTestableWidget(page: page));

    // verify that form is present
    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('test if all form fields are present', (WidgetTester tester) async {
    Widget page = CreateTrip();

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.text('Trip Details'), findsOneWidget);
    expect(find.text('General Information'), findsOneWidget);
    expect(find.text('End Date *'), findsOneWidget);
    expect(find.text('Destination *'), findsOneWidget);
    expect(find.text('Trip Title *'), findsOneWidget);
    expect(find.text('General Information'), findsOneWidget);
  });

  testWidgets('test if all form fields are present', (WidgetTester tester) async {
    Widget page = CreateTrip();

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('image_icon')), findsNWidgets(10));
  });

}
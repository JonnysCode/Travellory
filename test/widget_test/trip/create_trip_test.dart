import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/screens/trip/create_trip_screen.dart';
import 'package:travellory/services/auth.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements BaseAuthService {}

void main() {
  Widget makeTestableWidget({Widget child, BaseAuthService auth}) {
    return AuthProvider(
        auth: auth,
        child: MaterialApp(
          home: child,
        ));
  }

  testWidgets('test if create trip page is loaded', (WidgetTester tester) async {
    final testKey = Key('create_trip');

    MockAuth mockAuth = MockAuth();
    Widget page = CreateTrip();

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('test if form instance is found', (WidgetTester tester) async {
    Widget page = CreateTrip();
    MockAuth mockAuth = MockAuth();

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // verify that form is present
    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('test if all form fields are present', (WidgetTester tester) async {
    Widget page = CreateTrip();
    MockAuth mockAuth = MockAuth();

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    expect(find.text('Trip Details'), findsOneWidget);
    expect(find.text('General Information'), findsOneWidget);
    expect(find.text('End Date *'), findsOneWidget);
    expect(find.text('Destination(s) *'), findsOneWidget);
    expect(find.text('Trip Title *'), findsOneWidget);
    expect(find.text('General Information'), findsOneWidget);
  });

  testWidgets('test if all form fields are present', (WidgetTester tester) async {
    Widget page = CreateTrip();
    MockAuth mockAuth = MockAuth();

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    expect(find.byKey(Key('image_icon')), findsNWidgets(10));
  });

}
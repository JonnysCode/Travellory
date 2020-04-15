import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/screens/trip/create_trip_screen.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user_model.dart';

class MockUser extends Mock implements UserModel {}

void main() {
  Widget makeTestableWidget({Widget page, UserModel user}) {
    return Provider<UserModel>.value(
      value: user,
      child: MaterialApp(
        home: page,
      ),
    );
  }

  testWidgets('test if create trip page is loaded', (WidgetTester tester) async {
    final testKey = Key('create_trip');
    Widget page = CreateTrip();

    MockUser mockUser = MockUser();
    when(mockUser.uid).thenReturn('uid');
    expect(mockUser.uid, 'uid');

    await tester.pumpWidget(makeTestableWidget(page: page, user: mockUser));

    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('test if form instance is found', (WidgetTester tester) async {
    Widget page = CreateTrip();

    MockUser mockUser = MockUser();
    when(mockUser.uid).thenReturn('uid');
    expect(mockUser.uid, 'uid');

    await tester.pumpWidget(makeTestableWidget(page: page, user: mockUser));

    // verify that form is present
    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('test if all form fields are present', (WidgetTester tester) async {
    Widget page = CreateTrip();

    MockUser mockUser = MockUser();
    when(mockUser.uid).thenReturn('uid');
    expect(mockUser.uid, 'uid');

    await tester.pumpWidget(makeTestableWidget(page: page, user: mockUser));

    expect(find.text('Trip Details'), findsOneWidget);
    expect(find.text('General Information'), findsOneWidget);
    expect(find.text('End Date *'), findsOneWidget);
    expect(find.text('Destination(s) *'), findsOneWidget);
    expect(find.text('Trip Title *'), findsOneWidget);
    expect(find.text('General Information'), findsOneWidget);
  });

  testWidgets('test if all form fields are present', (WidgetTester tester) async {
    Widget page = CreateTrip();

    MockUser mockUser = MockUser();
    when(mockUser.uid).thenReturn('uid');
    expect(mockUser.uid, 'uid');

    await tester.pumpWidget(makeTestableWidget(page: page, user: mockUser));

    expect(find.byKey(Key('image_icon')), findsNWidgets(10));
  });

}
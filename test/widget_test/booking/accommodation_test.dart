import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/screens/bookings/add_accommodation.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TripModel tripModel = TripModel(
        name: 'Castle Discovery',
        startDate: '2020-05-12',
        endDate: '2020-05-25',
        destination: 'Munich',
        imageNr: 3);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/booking/accommodation', arguments: tripModel);
      },
      child: Container(
        color: const Color(0xFFFFFF00),
        child: const Text('X'),
      ),
    );
  }
}

void main() {
  Widget makeTestableWidget() {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (context) => const Wrapper(),
        '/booking/accommodation': (context) => Accommodation()
      },
    );
  }

  Future<void> pumpAccommodation(WidgetTester tester) async {
    await tester.tap(find.text('X'));
    await tester.pump();
  }

  testWidgets('test if accommodation page is loaded', (WidgetTester tester) async {
    final testKey = Key('Accommodation');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), findsNothing);

    await pumpAccommodation(tester);
    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), isOffstage);
  });

  testWidgets('test if form instance is found', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    await pumpAccommodation(tester);
    // verify that form is present
    expect(find.byType(Form, skipOffstage: false), isOffstage);
  });

  testWidgets('test if site title instance is found', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());

    await pumpAccommodation(tester);

    expect(find.byKey(Key('BookingSiteTitle'), skipOffstage: false), isOffstage);
  });

  testWidgets('test if section title instances are found', (WidgetTester tester) async {
    final testKey = Key('SectionTitle');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byKey(testKey, skipOffstage: false), findsNothing);

    await pumpAccommodation(tester);
    expect(find.byKey(testKey, skipOffstage: false), findsNWidgets(3));
  });

  testWidgets('test if dropdown menu instance is found', (WidgetTester tester) async {
    final testKey = Key('Dropdown Menu');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byKey(testKey, skipOffstage: false), findsNothing);

    await pumpAccommodation(tester);
    expect(find.byKey(testKey, skipOffstage: false), isOffstage);
  });

  testWidgets('test if first three form field instances are found', (WidgetTester tester) async {
    final testKey = Key('Form Field');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byKey(testKey, skipOffstage: false), findsNothing);

    await pumpAccommodation(tester);
    expect(find.text('Confirmation Number', skipOffstage: false), findsOneWidget);
    expect(find.text('Name *', skipOffstage: false), findsOneWidget);
    expect(find.text('Address *', skipOffstage: false), findsOneWidget);

    expect(find.byKey(testKey, skipOffstage: false), findsNWidgets(3));
  });

  testWidgets('test if check-in date field instance is found', (WidgetTester tester) async {
    final testKey = Key('Date Field');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byKey(testKey, skipOffstage: false), findsNothing);

    await pumpAccommodation(tester);
    expect(find.text('Check-In Date *', skipOffstage: false), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if check-in time field instance is found', (WidgetTester tester) async {
    final testKey = Key('Time Field');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byKey(testKey, skipOffstage: false), findsNothing);

    await pumpAccommodation(tester);
    expect(find.text('Check-In Time', skipOffstage: false), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if animated list is present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpAccommodation(tester);

    expect(find.byType(AnimatedList, skipOffstage: false), isOffstage);
  });
}

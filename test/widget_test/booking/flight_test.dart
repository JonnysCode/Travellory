import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/screens/bookings/add_flight.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TripModel tripModel = TripModel(
        name: 'Castle Discovery',
        startDate: '2020-05-12',
        endDate: '2020-05-25',
        destination: 'Munich',
        imageNr: 3
    );
    tripModel.init();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/booking/flight', arguments: tripModel);
      },
      child: Container(
        color: const Color(0xFFFFFF00),
        child: const Text('X'),
      ),
    );
  }
}

void main() {
  Widget makeTestableWidget(){
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (context) => const Wrapper(),
        '/booking/flight': (context) => Flight()
      },
    );
  }

  Future<void> pumpFlight(WidgetTester tester) async {
    await tester.tap(find.text('X'));
    await tester.pump();
  }

  testWidgets('test if Flight page is loaded', (WidgetTester tester) async {
    final testKey = Key('Flight');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), findsNothing);

    await pumpFlight(tester);
    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), isOffstage);
  });

  testWidgets('test if form instance is found', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    await pumpFlight(tester);
    // verify that form is present
    expect(find.byType(Form, skipOffstage: false), isOffstage);
  });


  testWidgets('test if all form fields are present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpFlight(tester);

    expect(find.byKey(Key('BookingSiteTitle'), skipOffstage: false), findsOneWidget);
    expect(find.byKey(Key('SectionTitle'), skipOffstage: false), findsNWidgets(4));
    expect(find.byIcon(FontAwesomeIcons.plane, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.ticketAlt, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.chair, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.planeDeparture, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.planeArrival, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.calendarAlt, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.clock, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.stickyNote, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if submit button is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());
    await pumpFlight(tester);
    // Verify that form is present.
    expect(find.byKey(Key('SubmitButton'), skipOffstage: false), isOffstage);
  });

  testWidgets('test if submit button is tapped', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());
    await pumpFlight(tester);
    // Verify that form is present.
    expect(find.byKey(Key('SubmitButton'), skipOffstage: false), isOffstage);
    await tester.tap(find.byKey(Key('SubmitButton'), skipOffstage:false));
  });


  testWidgets('test if cancel button is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());
    await pumpFlight(tester);

    // Verify that form is present.
    expect(find.byKey(Key('CancelButton'), skipOffstage: false), isOffstage);
  });
}
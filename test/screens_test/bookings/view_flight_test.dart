import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/src/models/flight_model.dart';
import 'package:travellory/src/screens/flight/view_flight.dart';

final FlightModel model = FlightModel()
  ..departureLocation = 'Zürich'
  ..departureDate = '2020-05-01'
  ..departureTime = '7:30'
  ..arrivalLocation = 'London'
  ..arrivalDate = '2020-05-01'
  ..arrivalTime = '8:35';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/view/flight', arguments: model);
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
        '/view/flight': (context) => FlightView()
      },
    );
  }

  Future<void> pumpFlightView(WidgetTester tester) async {
    await tester.tap(find.text('X'));
    await tester.pump();
  }

  testWidgets('test if FlightView page is loaded', (WidgetTester tester) async {
    final testKey = Key('FlightView');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), findsNothing);

    await pumpFlightView(tester);
    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), isOffstage);
  });

  testWidgets('test if view booking header is present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpFlightView(tester);

    expect(find.byKey(Key('ViewBookingHeader'), skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if view flight page content is present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpFlightView(tester);

    expect(find.byKey(Key('FlightViewPage'), skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if bottom bar is present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpFlightView(tester);

    expect(find.byKey(Key('BottomBar'), skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if exit view button is present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpFlightView(tester);

    expect(find.byKey(Key('ExitViewPage'), skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if all view fields are present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpFlightView(tester);

    expect(find.byKey(Key('SectionTitle'), skipOffstage: false), findsNWidgets(5));
    expect(find.byIcon(FontAwesomeIcons.ticketAlt, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.plane, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.chair, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.planeDeparture, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.planeArrival, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.calendarAlt, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.clock, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.stickyNote, skipOffstage: false), findsOneWidget);
  });
}

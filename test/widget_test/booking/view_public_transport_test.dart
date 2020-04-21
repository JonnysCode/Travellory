import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/screens/bookings/view_public_transport.dart';

final PublicTransportModel model = PublicTransportModel()
  ..transportationType = 'Taxi'
  ..departureLocation = 'London City'
  ..departureDate = '2020-05-04'
  ..departureTime = '10:55'
  ..arrivalLocation = 'Gatwick Airport'
  ..arrivalDate = '2020-05-04'
  ..arrivalTime = '11:30'
  ..tripUID = ''
  ..uid = ''
  ..publicTransportCompany = ''
  ..specificType = ''
  ..booked = true
  ..seatReserved = false
  ..referenceNr = ''
  ..reservationCompany = ''
  ..seat = ''
  ..notes = 'Some Notes';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/view/publictransport', arguments: model);
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
        '/view/publictransport': (context) => PublicTransportView()
      },
    );
  }

  Future<void> pumpPublicTransportView(WidgetTester tester) async {
    await tester.tap(find.text('X'));
    await tester.pump();
  }

  testWidgets('test if PublicTransportView page is loaded', (WidgetTester tester) async {
    final testKey = Key('PublicTransportView');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), findsNothing);

    await pumpPublicTransportView(tester);
    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), isOffstage);
  });

  testWidgets('test if view booking header is present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpPublicTransportView(tester);

    expect(find.byKey(Key('ViewBookingHeader'), skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if view accommodation page content is present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpPublicTransportView(tester);

    expect(find.byKey(Key('PublicTransportViewPage'), skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if bottom bar is present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpPublicTransportView(tester);

    expect(find.byKey(Key('BottomBar'), skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if all view fields are present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpPublicTransportView(tester);

    expect(find.byKey(Key('SectionTitle'), skipOffstage: false), findsNWidgets(4));
    expect(find.byIcon(FontAwesomeIcons.clock, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.calendarAlt, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.solidBuilding, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.mapMarkerAlt, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.ticketAlt, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.stickyNote, skipOffstage: false), findsOneWidget);
  });
}

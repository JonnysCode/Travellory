import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/screens/trip/flight.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TripModel tripModel = TripModel(
        name: 'Castle Discovery',
        startDate: DateTime(2020, 5, 12),
        endDate: DateTime(2020, 5, 25),
        destination: 'Munich',
        imageNr: 3
    );
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

  testWidgets('test if form is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());
    await pumpFlight(tester);

    // Verify that form is present.
    expect(find.byType(Form, skipOffstage: false), isOffstage);

    // Verify that form fields are present.
    expect(find.byIcon(Icons.airline_seat_recline_normal, skipOffstage: false), isOffstage);
    expect(find.byIcon(Icons.speaker_notes, skipOffstage: false), isOffstage);
  });

  testWidgets('test if submit button is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());
    await pumpFlight(tester);
    // Verify that form is present.
    expect(find.byKey(Key('SubmitButton'), skipOffstage: false), isOffstage);
  });

  testWidgets('test if cancel button is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());
    await pumpFlight(tester);

    // Verify that form is present.
    expect(find.byKey(Key('CancelButton'), skipOffstage: false), isOffstage);
  });
}
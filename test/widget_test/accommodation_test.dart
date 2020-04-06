import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/screens/trip/accommodation.dart';

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
  Widget makeTestableWidget(){
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

//  testWidgets('test if form is present', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(makeTestableWidget());
//    await pumpAccommodation(tester);
//
//    // Verify that form is present.
//    expect(find.byType(Form, skipOffstage: false), isOffstage);
//
//    // Verify that form fields are present.
//    expect(find.byIcon(Icons.confirmation_number, skipOffstage: false), isOffstage);
//    expect(find.byIcon(Icons.supervised_user_circle, skipOffstage: false), isOffstage);
//    expect(find.byIcon(Icons.location_on, skipOffstage: false), isOffstage);
//    expect(find.byIcon(Icons.location_on, skipOffstage: false), isOffstage);
//    expect(find.byIcon(Icons.speaker_notes, skipOffstage: false), isOffstage);
//  });
//
//  testWidgets('test if submit button is present', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(makeTestableWidget());
//    await pumpAccommodation(tester);
//    // Verify that form is present.
//    expect(find.byKey(Key('SubmitButton'), skipOffstage: false), isOffstage);
//  });
//
//  testWidgets('test if cancel button is present', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(makeTestableWidget());
//    await pumpAccommodation(tester);
//
//    // Verify that form is present.
//    expect(find.byKey(Key('CancelButton'), skipOffstage: false), isOffstage);
//  });
}
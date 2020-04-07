import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/screens/trip/rental_car.dart';

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
        Navigator.pushNamed(context, '/booking/rentalCar', arguments: tripModel);
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
        '/booking/rentalCar': (context) => RentalCar()
      },
    );
  }

  Future<void> pumpRentalCar(WidgetTester tester) async {
    await tester.tap(find.text('X'));
    await tester.pump();
  }

  testWidgets('test if Rental Car page is loaded', (WidgetTester tester) async {
    final testKey = Key('Rental Car');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), findsNothing);

    await pumpRentalCar(tester);
    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), isOffstage);
  });

  testWidgets('test if form instance is found', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    await pumpRentalCar(tester);
    // verify that form is present
    expect(find.byType(Form, skipOffstage: false), isOffstage);
  });

  testWidgets('test if form is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());
    await pumpRentalCar(tester);

    // Verify that form is present.
    expect(find.byType(Form, skipOffstage: false), isOffstage);
  });

  testWidgets('test if all form fields are present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await pumpRentalCar(tester);

    expect(find.byKey(Key('BookingSiteTitle'), skipOffstage: false), findsOneWidget);
    expect(find.byKey(Key('SectionTitle'), skipOffstage: false), findsNWidgets(5));
    expect(find.byIcon(Icons.confirmation_number, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(Icons.supervised_user_circle, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(Icons.location_on, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(Icons.date_range, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(Icons.access_time, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(Icons.directions_car, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(Icons.speaker_notes, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if submit button is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());
    await pumpRentalCar(tester);
    // Verify that form is present.
    expect(find.byKey(Key('SubmitButton'), skipOffstage: false), isOffstage);
  });

  testWidgets('test if cancel button is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());
    await pumpRentalCar(tester);

    // Verify that form is present.
    expect(find.byKey(Key('CancelButton'), skipOffstage: false), isOffstage);
  });
}
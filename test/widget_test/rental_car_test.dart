import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/screens/trip/rentalCar.dart';

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
      //key: Key('RentalCar'),
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

    // Verify that all form fields are present.
    expect(find.byIcon(Icons.confirmation_number, skipOffstage: false), isOffstage);
    expect(find.byIcon(Icons.supervised_user_circle, skipOffstage: false), isOffstage);
    expect(find.byIcon(Icons.speaker_notes, skipOffstage: false), isOffstage);
  });

  testWidgets('test if submit button is present', (WidgetTester tester) async {

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());
    await pumpRentalCar(tester);
    // Verify that form is present.
    expect(find.byKey(Key('SubmitButton'), skipOffstage: false), isOffstage);
  });

  testWidgets('test if cancel button is present', (WidgetTester tester) async {
    Widget page = RentalCar();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());
    await pumpRentalCar(tester);

    // Verify that form is present.
    expect(find.byKey(Key('CancelButton'), skipOffstage: false), isOffstage);
  });

  // TODO this doesn't work yet
//  testWidgets('validate form input error message', (WidgetTester tester) async {
//    Widget page = RentalCar();
//    final inputErrorFinder = find.text('Please enter the required information');
//    final buttonFinder = find.text('SUBMIT');
//
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(makeTestableWidget(child: page));
//
//    await tester.tap(buttonFinder);
//
//    await tester.pump(const Duration(milliseconds: 1000)); // add delay
//
//    expect(inputErrorFinder, findsOneWidget);
//  });
}
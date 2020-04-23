
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/widgets/trip/trip_card.dart';

TripModel _tripModel = TripModel(
  name: 'name',
  startDate: '12-05-2020',
  endDate: '20-06-2020',
  destination: 'destination',
  imageNr: 3,
);

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('test if SpeedDial is rendered', (WidgetTester tester) async {
    _tripModel.init();
    Widget page = TripCard(tripModel: _tripModel);

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that all the information is present.
    expect(find.text('name'), findsOneWidget);
    expect(find.text('destination'), findsOneWidget);
  });
}
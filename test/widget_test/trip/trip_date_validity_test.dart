import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/utils/trip_date_validity.dart';

class TripsProviderMock extends Mock implements TripsProvider {}

void main() {
  Widget makeTestableWidget(TripsProvider tripsProvider) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        home: Material(child: Builder(
          builder: (BuildContext context) {
            bool tripDateIsValidBool = tripDateIsValid('2020-05-20', 'no label', context);
            expect(tripDateIsValidBool, isFalse);
            return Container();
          },
        )),
      ),
    );
  }

  testWidgets('asdf', (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();

    await tester.pumpWidget(makeTestableWidget(tripsProvider));
  });
}

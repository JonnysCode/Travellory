import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/screens/trip/create_trip_screen.dart';
import 'package:travellory/services/database/delete_database.dart';
import 'package:travellory/services/database/edit_database.dart';
import 'package:travellory/utils/trip_date_validity.dart';
import 'package:travellory/widgets/bookings/edit.dart';
import 'package:travellory/widgets/bookings/edit_delete_dialogs.dart';
import 'package:travellory/widgets/buttons/booking_button.dart';
import 'package:travellory/widgets/buttons/submit_button.dart';
import 'package:travellory/widgets/forms/date_form_field.dart';

final ActivityModel activityModel = ActivityModel()
  ..category = 'Historic'
  ..title = 'Museum visit'
  ..imageNr = 9
  ..imagePath = 'assets/images/activity/activity_9.png'
  ..location = "100 King's Cross Rd, London WC1X 9DT"
  ..startDate = '2020-05-01'
  ..startTime = '12:00'
  ..endDate = '2020-05-01';

class TripsProviderMock extends Mock implements TripsProvider {}

TripModel tripModel = TripModel(
    name: 'London Trip',
    startDate: '2020-05-01',
    endDate: '2020-05-10',
    destination: 'London',
    imageNr: 3);

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

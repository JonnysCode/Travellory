import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/src/models/accommodation_model.dart';
import 'package:travellory/src/models/activity_model.dart';
import 'package:travellory/src/models/flight_model.dart';
import 'package:travellory/src/models/public_transport_model.dart';
import 'package:travellory/src/models/rental_car_model.dart';
import 'package:travellory/src/models/trip_model.dart';
import 'package:travellory/src/models/user_model.dart';
import 'package:travellory/src/providers/single_trip_provider.dart';
import 'package:travellory/src/providers/trips_provider.dart';
import 'package:travellory/src/screens/main/home_page.dart';
import 'package:travellory/src/screens/schedule/trip_schedule.dart';

TripModel _tripModel = TripModel(
  name: 'name',
  startDate: '12-05-2020',
  endDate: '20-06-2020',
  imageNr: 3,
);

List<FlightModel> _flights = <FlightModel>[];
List<AccommodationModel> _accommodations = <AccommodationModel>[];
List<ActivityModel> _activities = <ActivityModel>[];
List<PublicTransportModel> _publicTransports = <PublicTransportModel>[];
List<RentalCarModel> _rentalCars = <RentalCarModel>[];

class TripsProviderMock extends Mock implements TripsProvider{}
class SingleTripProviderMock extends Mock implements SingleTripProvider{}

void main(){
  Widget makeTestableWidget({Widget child, TripsProvider tripsProvider}){
    return Provider<UserModel>(
      create: (_) => UserModel(displayName: 'name'),
      child: ChangeNotifierProvider<TripsProvider>.value(
        value: tripsProvider,
        child: MaterialApp(
          home: Scaffold(
            body: child,
          ),
        ),
      ),
    );
  }

  testWidgets('test if HomePage is rendered', (WidgetTester tester) async {
    Widget page = HomePage();
    TripsProvider tripsProvider = TripsProviderMock();
    SingleTripProvider trip = SingleTripProviderMock();

    when(tripsProvider.activeTrip).thenReturn(trip);
    when(trip.tripModel).thenReturn(_tripModel);
    when(trip.activities).thenReturn(_activities);
    when(trip.accommodations).thenReturn(_accommodations);
    when(trip.flights).thenReturn(_flights);
    when(trip.publicTransports).thenReturn(_publicTransports);
    when(trip.rentalCars).thenReturn(_rentalCars);
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, tripsProvider: tripsProvider));

    // Verify that the HomePage is present.
    expect(find.byKey(Key('home_page')), findsOneWidget);
  });

  testWidgets('test if SpeedDial is rendered', (WidgetTester tester) async {
    Widget page = HomePage();
    TripsProvider tripsProvider = TripsProviderMock();
    SingleTripProvider trip = SingleTripProviderMock();

    when(tripsProvider.activeTrip).thenReturn(trip);
    when(trip.tripModel).thenReturn(_tripModel);
    when(trip.activities).thenReturn(_activities);
    when(trip.accommodations).thenReturn(_accommodations);
    when(trip.flights).thenReturn(_flights);
    when(trip.publicTransports).thenReturn(_publicTransports);
    when(trip.rentalCars).thenReturn(_rentalCars);
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, tripsProvider: tripsProvider));

    // Verify that the HomePage is present.
    expect(find.byKey(Key('home_page_dial')), findsOneWidget);
  });

  testWidgets('test if HomePage is rendered', (WidgetTester tester) async {
    Widget page = HomePage();
    TripsProvider tripsProvider = TripsProviderMock();
    SingleTripProvider trip = SingleTripProviderMock();

    when(tripsProvider.activeTrip).thenReturn(trip);
    when(trip.tripModel).thenReturn(_tripModel);
    when(trip.activities).thenReturn(_activities);
    when(trip.accommodations).thenReturn(_accommodations);
    when(trip.flights).thenReturn(_flights);
    when(trip.publicTransports).thenReturn(_publicTransports);
    when(trip.rentalCars).thenReturn(_rentalCars);
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, tripsProvider: tripsProvider));

    // Verify that the HomePage is present.
    expect(find.byType(Schedule), findsOneWidget);
  });
}
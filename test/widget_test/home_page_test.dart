import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/screens/home/pages/home_page.dart';

TripModel _tripModel = TripModel(
  name: 'name',
  startDate: '12-05-2020',
  endDate: '20-06-2020',
  destination: 'destination',
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
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        home: Scaffold(
          body: child,
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
    expect(find.byKey(Key('home_schedule')), findsOneWidget);
  });

}
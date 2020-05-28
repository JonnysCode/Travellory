import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/src/models/accommodation_model.dart';
import 'package:travellory/src/models/rental_car_model.dart';
import 'package:travellory/src/models/trip_model.dart';
import 'package:travellory/src/providers/trips_provider.dart';
import 'package:travellory/src/components/forms/date_form_field.dart';

class TripsProviderMock extends Mock implements TripsProvider {}

void main() {
  testWidgets('Test Date Field required exists and validation for empty fails',
      (WidgetTester tester) async {
    final GlobalKey<FormState> testKey = GlobalKey<FormState>();
    TripsProviderMock tripsProvider = TripsProviderMock();

    // for testing purposes we will use a rental car model here
    final RentalCarModel testModel = RentalCarModel();

    final DateFormField testDate = DateFormField(
      labelText: "Test Date",
      icon: Icon(Icons.date_range),
      optional: false,
      chosenDateString: (value) => testModel.pickupDate = value,
    );

    Widget makeTestableWidget(TripsProvider tripsProvider) {
      return ChangeNotifierProvider<TripsProvider>.value(
        value: tripsProvider,
        child: MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(devicePixelRatio: 1.0),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: Material(
                  child: Form(
                    key: testKey,
                    child: testDate,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(tripsProvider));

    bool validateForm() {
      return (testKey.currentState.validate());
    }

    Future<void> checkEmptyText() async {
      await tester.tap(find.byType(TextFormField));
      bool validate = validateForm();
      expect(testModel.pickupDate, equals(''));
      expect(validate, isFalse);
    }

    await checkEmptyText();
  });

  testWidgets('Test Date Field optional exists and validation for empty passes',
      (WidgetTester tester) async {
    final GlobalKey<FormState> testKey = GlobalKey<FormState>();

    // for testing purposes we will use a rental car model here
    final RentalCarModel testModel = RentalCarModel();

    final DateFormField testDate = DateFormField(
      labelText: "Test Date",
      icon: Icon(Icons.date_range),
      optional: true,
      chosenDateString: (value) => testModel.pickupDate = value,
    );

    Widget makeTestableWidget() {
      return MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(devicePixelRatio: 1.0),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: Material(
                child: Form(
                  key: testKey,
                  child: testDate,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    bool validateForm() {
      return (testKey.currentState.validate());
    }

    Future<void> checkEmptyText() async {
      await tester.tap(find.byType(TextFormField));
      bool validate = validateForm();
      expect(testModel.pickupDate, equals(''));
      expect(validate, isTrue);
    }

    await checkEmptyText();
  });

  testWidgets('Test Date Field for Second Date exists', (WidgetTester tester) async {
    final GlobalKey<FormState> testKey = GlobalKey<FormState>();
    final GlobalKey<DateFormFieldState> testDateFieldOneKey = GlobalKey<DateFormFieldState>();
    final GlobalKey<DateFormFieldState> testDateFieldTwoKey = GlobalKey<DateFormFieldState>();

    final AccommodationModel testModel = AccommodationModel()
      ..type = 'hotel'
      ..name = 'Travelodge'
      ..address = "100 King's Cross Rd, London WC1X 9DT"
      ..checkinDate = '01-05-2020'
      ..checkinTime = '12:00'
      ..checkoutDate = '05-05-2020';

    TripModel tripModel = TripModel(
        name: 'Test Trip',
        startDate: '01-05-2020',
        endDate: '05-05-2020',
        destination: 'London',
        imageNr: 3);

    final DateFormField testDateOne = DateFormField(
      key: testDateFieldOneKey,
      listenerKey: testDateFieldTwoKey,
      initialValue: testModel.checkinDate,
      labelText: "TestDateOne",
      icon: Icon(Icons.date_range),
      optional: false,
      tripModel: tripModel,
      model: testModel,
      chosenDateString: (value) => testModel.checkinDate = value,
    );

    final DateFormField testDateTwo = DateFormField(
      key: testDateFieldTwoKey,
      labelText: "TestDateTwo",
      icon: Icon(Icons.date_range),
      optional: false,
      tripModel: tripModel,
      model: testModel,
      chosenDateString: (value) => testModel.checkoutDate = value,
    );

    Widget makeTestableWidget() {
      return MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(devicePixelRatio: 1.0),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: Material(
                child: Form(
                    key: testKey,
                    child: Column(children: <Widget>[
                      testDateOne,
                      testDateTwo,
                    ])),
              ),
            ),
          ),
        ),
      );
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    expect(find.byKey(testDateFieldOneKey, skipOffstage: false), findsOneWidget);
    expect(find.byKey(testDateFieldTwoKey, skipOffstage: false), findsOneWidget);
    expect(find.text('01-05-2020', skipOffstage: false), findsOneWidget);
  });

  Future<void> enterDate(String date, Key key, WidgetTester tester) async {
    await tester.tap(find.byKey(key));
    Finder dateField = find.byKey(key);
    await tester.showKeyboard(dateField);
    await tester.enterText(dateField, date);
  }

  testWidgets('Test Date Field enter date works', (WidgetTester tester) async {
    final GlobalKey<FormState> testKey = GlobalKey<FormState>();
    final GlobalKey<DateFormFieldState> testDateFieldOneKey = GlobalKey<DateFormFieldState>();
    final GlobalKey<DateFormFieldState> testDateFieldTwoKey = GlobalKey<DateFormFieldState>();

    final AccommodationModel testModel = AccommodationModel()
      ..type = 'hotel'
      ..name = 'Travelodge'
      ..address = "100 King's Cross Rd, London WC1X 9DT"
      ..checkinDate = ''
      ..checkinTime = '12:00'
      ..checkoutDate = '';

    TripModel tripModel = TripModel(
        name: 'Test Trip',
        startDate: '01-05-2020',
        endDate: '05-05-2020',
        destination: 'London',
        imageNr: 3);

    final DateFormField testDateOne = DateFormField(
      key: testDateFieldOneKey,
      listenerKey: testDateFieldTwoKey,
      initialValue: testModel.checkinDate,
      labelText: "TestDateOne",
      icon: Icon(Icons.date_range),
      optional: false,
      tripModel: tripModel,
      model: testModel,
      chosenDateString: (value) => testModel.checkinDate = value,
    );

    final DateFormField testDateTwo = DateFormField(
      key: testDateFieldTwoKey,
      labelText: "TestDateTwo",
      icon: Icon(Icons.date_range),
      optional: false,
      tripModel: tripModel,
      model: testModel,
      chosenDateString: (value) => testModel.checkoutDate = value,
    );

    Widget makeTestableWidget() {
      return MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(devicePixelRatio: 1.0),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: Material(
                child: Form(
                    key: testKey,
                    child: Column(children: <Widget>[
                      testDateOne,
                      testDateTwo,
                    ])),
              ),
            ),
          ),
        ),
      );
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    expect(find.byKey(testDateFieldOneKey, skipOffstage: false), findsOneWidget);
    expect(find.byKey(testDateFieldTwoKey, skipOffstage: false), findsOneWidget);

    await enterDate('01-05-2020', testDateFieldOneKey, tester);
    await tester.pump();
    expect(find.text('01-05-2020', skipOffstage: false), findsOneWidget);
  });

  testWidgets('Test Date Field is in trip range', (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();

    final GlobalKey<FormState> testKey = GlobalKey<FormState>();
    final GlobalKey<DateFormFieldState> testDateFieldOneKey = GlobalKey<DateFormFieldState>();

    final AccommodationModel testModel = AccommodationModel()
      ..type = 'hotel'
      ..name = 'Travelodge'
      ..checkinDate = '01-05-2020'
      ..checkoutDate = '10-05-2020'
      ..address = "100 King's Cross Rd, London WC1X 9DT";

    TripModel tripModel = TripModel(
        name: 'Test Trip',
        startDate: '01-05-2020',
        endDate: '05-05-2020',
        destination: 'London',
        imageNr: 3);

    Widget makeTestableWidget(TripsProviderMock tripsProvider) {
      return ChangeNotifierProvider<TripsProvider>.value(
        value: tripsProvider,
        child: MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(devicePixelRatio: 1.0),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: Material(
                  child: Form(
                    key: testKey,
                    child: DateFormField(
                      key: testDateFieldOneKey,
                      initialValue: testModel.checkoutDate,
                      labelText: 'Test Check Out Date',
                      icon: Icon(Icons.date_range),
                      optional: false,
                      tripModel: tripModel,
                      model: testModel,
                      chosenDateString: (value) => testModel.checkoutDate = value,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(tripsProvider));

    bool validateForm() {
      return (testKey.currentState.validate());
    }

    Future<void> checkValidationFails() async {
      bool result = validateForm();
      expect(result, isFalse);
    }

    await checkValidationFails();
  });
}

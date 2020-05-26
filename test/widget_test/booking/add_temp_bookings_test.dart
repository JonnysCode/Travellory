import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:travellory/src/models/user_model.dart';
import 'package:travellory/src/providers/trips_provider.dart';
import 'package:travellory/src/screens/temp_bookings/temp_bookings.dart';
import 'package:provider/provider.dart';

class TripsProviderMock extends Mock implements TripsProvider {}

void main() {
  Widget makeTestableWidget(TripsProvider tripsProvider) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        home: AddTempBookingsScreen(),
      ),
    );
  }

  testWidgets('test if add temp bookings loads all needed texts', (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();
    when(tripsProvider.user).thenReturn(UserModel(uid: 'uid', displayName: 'name'));

    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    
    expect(find.text('Accommodations'), findsOneWidget);
    expect(find.text('Forward your booking confirmation mails to'), findsOneWidget);
    expect(find.text('travellory@in.parseur.com'), findsOneWidget);
    expect(find.text('and add them to a trip here.'), findsOneWidget);
  });

}
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/widgets/bookings/edit_delete_dialogs.dart';
import 'package:travellory/widgets/buttons/buttons.dart';

void main() {
  testWidgets('Test delete button exists', (WidgetTester tester) async {
    final testKey = Key('DeleteButton');
    final String alertText = 'Test';

    Widget makeTestableWidget() {
      return MaterialApp(home: Material(child: Builder(builder: (BuildContext context) {
        return Center(
          child: DeleteButton(
            highlightColor: Theme.of(context).primaryColor,
            fillColor: Theme.of(context).primaryColor,
            onDelete: () {
              showDeleteDialog(context, alertText);
            },
          ),
        );
      })));
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(DeleteButton), findsOneWidget);
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('Test showDeleteDialog exists', (WidgetTester tester) async {
    final String alertText = 'Test';
    final Key testKey = Key('ShowDeleteDialog');

    Widget makeTestableWidget() {
      return MaterialApp(home: Material(child: Builder(builder: (BuildContext context) {
        return Center(
          child: DeleteButton(
            highlightColor: Theme.of(context).primaryColor,
            fillColor: Theme.of(context).primaryColor,
            onDelete: () {
              showDeleteDialog(context, alertText);
            },
          ),
        );
      })));
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(DeleteButton), findsOneWidget);
    await tester.tap(find.byType(DeleteButton));
    await tester.pump();
    expect(find.text(alertText), findsOneWidget);
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('Test onDeleteBooking can be tapped and AddToDataBaseFailedDialog appears',
      (WidgetTester tester) async {
    final String alertText = 'TestOnDelete';
    final Key testKey = Key('deleteButton');

    Widget makeTestableWidget() {
      return MaterialApp(home: Material(child: Builder(builder: (BuildContext context) {
        return Center(
          child: DeleteButton(
            highlightColor: Theme.of(context).primaryColor,
            fillColor: Theme.of(context).primaryColor,
            onDelete: () {
              showDeleteDialog(context, alertText);
            },
          ),
        );
      })));
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(DeleteButton), findsOneWidget);
    await tester.tap(find.byType(DeleteButton));
    await tester.pump();
    expect(find.text(alertText), findsOneWidget);

    // find 'Continue with Delete' Button and tap it
    expect(find.byKey(testKey), findsOneWidget);
    await tester.tap(find.byKey(testKey));
    await tester.pump();

    // finds add to database failed dialog
    expect(find.byKey(Key('AddToDataBaseFailedDialog')), findsOneWidget);
  });
}

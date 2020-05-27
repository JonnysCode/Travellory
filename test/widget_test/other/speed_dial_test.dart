import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/src/components/buttons/speed_dial_button.dart';

List<Dial> _dials = <Dial>[
  Dial(
      icon: FontAwesomeIcons.envelope,
      description: 'Manage forwarded bookings',
      onTab: (){}
  ),
  Dial(
      icon: FontAwesomeIcons.theaterMasks,
      description: 'Add Attraction',
      onTab: (){}
  ),
  Dial(
      icon: FontAwesomeIcons.car,
      description: 'Add Rental Car',
      onTab: (){}
  ),
  Dial(
      icon: FontAwesomeIcons.bus,
      description: 'Add Public Transportation',
      onTab: (){}
  ),
  Dial(
      icon: FontAwesomeIcons.bed,
      description: 'Add Accommodation',
      onTab: (){}
  ),
  Dial(
      icon: FontAwesomeIcons.plane,
      description: 'Add Flight',
      onTab: (){}
  ),
];

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('test if SpeedDial is rendered', (WidgetTester tester) async {
    Widget page = SpeedDialButton(
      dials: _dials,
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that dial button is present.
    expect(find.byKey(Key('dial_button')), findsOneWidget);
  });

  testWidgets('test if all dials are present', (WidgetTester tester) async {
    Widget page = SpeedDialButton(
      dials: _dials,
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // press dial button
    await tester.press(find.byKey(Key('dial_button')));
    await tester.pump();

    // Verify that all button are present.
    expect(find.byIcon(FontAwesomeIcons.envelope), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.theaterMasks), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.car), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.bus), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.bed), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.plane), findsOneWidget);
  });
}
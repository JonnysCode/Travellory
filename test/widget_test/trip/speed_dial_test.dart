import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/widgets/buttons/speed_dial_button.dart';

const List<Dial> _dials = <Dial>[
  Dial(
      icon: FontAwesomeIcons.envelope,
      description: 'Manage forwarded bookings'
  ),
  Dial(
      icon: FontAwesomeIcons.theaterMasks,
      description: 'Add Attraction'
  ),
  Dial(
      icon: FontAwesomeIcons.car,
      description: 'Add Rental Car'
  ),
  Dial(
      icon: FontAwesomeIcons.bus,
      description: 'Add Public Transportation'
  ),
  Dial(
      icon: FontAwesomeIcons.bed,
      description: 'Add Accommodation'
  ),
  Dial(
      icon: FontAwesomeIcons.plane,
      description: 'Add Flight'
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
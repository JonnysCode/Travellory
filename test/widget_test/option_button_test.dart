import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/widgets/buttons/option_button.dart';

void main(){
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
          home: Material(child: child),
        );
  }

  testWidgets('option button test', (WidgetTester tester) async {
    Widget optionButton = OptionButton(
      optionItems: <OptionItem>[
        OptionItem(
          icon: Icons.add,
          description: 'description'
        ),
      ],
    );

    await tester.pumpWidget(makeTestableWidget(child: optionButton));

    expect(find.byIcon(FontAwesomeIcons.ellipsisV), findsOneWidget);

    await tester.tap(find.byIcon(FontAwesomeIcons.ellipsisV));

  });
}
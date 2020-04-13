import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/screens/home/pages/profile_page.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/utils/image_picker_handler.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/image_picker_dialog.dart';

import 'profile_page_test.dart';

void main() {
  Widget makeTestableWidget({Widget child, BaseAuthService auth}) {
    return AuthProvider(
        auth: auth,
        child: MaterialApp(
          home: child,
        ));
  }

  testWidgets('test if page has the select menu widget',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    ImagePickerHandler _listener;
    AnimationController _controller;
    ImagePickerDialog page = ImagePickerDialog(_listener, _controller);

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // Verify that the selection menu is present.
    expect(find.byKey(Key('selection_menu')), findsOneWidget);
  });

  testWidgets('test if page has three GestureDetector',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    ImagePickerHandler _listener;
    AnimationController _controller;
    ImagePickerDialog page = ImagePickerDialog(_listener, _controller);

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));
    var gestureDetector = find.byType(GestureDetector);

    // Verify that the profile page has three GestureDetector
    expect(gestureDetector, findsNWidgets(3));
  });

  testWidgets('test if page has three FashionFetishTexts',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    ImagePickerHandler _listener;
    AnimationController _controller;
    ImagePickerDialog page = ImagePickerDialog(_listener, _controller);

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));
    var fashionFetishText = find.byType(FashionFetishText);

    // Verify that the profile page has three FashionFetishText
    expect(fashionFetishText, findsNWidgets(3));
    expect(find.text('Take Photo'), findsOneWidget);
    expect(find.text('Choose from Library'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('test if page pick image', (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    Widget page = ProfilePage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));
    await tester.tap(find.byKey(Key('image_pick')));
    await tester.pump();

    // Verify that the page pick image
    expect(find.byKey(Key('selection_menu')), findsOneWidget);
  });
}

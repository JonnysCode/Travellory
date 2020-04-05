import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/utils/image_picker_handler.dart';
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

  testWidgets('test if page has gesture detector', (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    ImagePickerHandler _listener;
    AnimationController _controller;
    ImagePickerDialog page = ImagePickerDialog(_listener, _controller);

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));
    var gestureDetector = find.byType(GestureDetector);

    // Verify that the profile page has three gesture detectors
    expect(gestureDetector, findsNWidgets(3));
  });
}

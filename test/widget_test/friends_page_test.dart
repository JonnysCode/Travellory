import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/screens/home/pages/friends_page.dart';
import 'package:travellory/services/auth.dart';

class MockAuth extends Mock implements BaseAuthService {}

void main() {
  Widget makeTestableWidget({Widget child, BaseAuthService auth}) {
    return AuthProvider(
        auth: auth,
        child: MaterialApp(
          home: child,
        ));
  }

  testWidgets('test if page is the friends page', (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    FriendsPage page = FriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // Verify that the friends page is present.
    expect(find.byKey(Key('friends_page')), findsOneWidget);
  });
}

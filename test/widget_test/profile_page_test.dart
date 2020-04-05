import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/screens/home/pages/profile_page.dart';
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

  testWidgets('test if page is the profile page', (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    ProfilePage page = ProfilePage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // Verify that the profile page is present.
    expect(find.byKey(Key('profile_page')), findsOneWidget);
    // TODO expect(find.byKey(Key('display_user')), findsOneWidget);
  });

  testWidgets('test if profile page has a circle avatar',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    ProfilePage page = ProfilePage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));
    var circleAvatar = find.byType(CircleAvatar);
    var text = find.byType(Text);

    // Verify that the ProfilePage has a circleAvatar.
    expect(circleAvatar, findsOneWidget);
    // TODO expect(text, findsNWidgets(3));
  });
}

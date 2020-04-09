import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/screens/home/pages/profile_page.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/widgets/font_widgets.dart';

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
  });

  testWidgets('test if profile page use user information class',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    UserInformation page = UserInformation();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // Verify that the profile page use user information class
    expect(find.byKey(Key('display_user')), findsOneWidget);
  });

  testWidgets('test if profile page has a circle avatar',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    ProfilePage page = ProfilePage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));
    var circleAvatar = find.byType(CircleAvatar);

    // Verify that the profile page has a circleAvatar.
    expect(circleAvatar, findsOneWidget);
  });

  testWidgets('test if profile page has three icons',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    UserInformation page = UserInformation();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // Verify that the profile page has a circleAvatar.
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.byIcon(Icons.email), findsOneWidget);
    expect(find.byIcon(Icons.date_range), findsOneWidget);
  });

  testWidgets('test if profile page has a logout button',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    ProfilePage page = ProfilePage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));
    var fashionFetishText = find.byType(FashionFetishText);

    // Verify that the ProfilePage has a exit icon and logout text.
    expect(fashionFetishText, findsOneWidget);
    expect(find.byIcon(Icons.exit_to_app), findsNWidgets(1));
  });
}

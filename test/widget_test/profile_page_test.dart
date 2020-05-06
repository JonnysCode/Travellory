import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/screens/home/pages/profile_page.dart';
import 'package:travellory/services/authentication/auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class MockAuth extends Mock implements BaseAuthService {}
class MockFirebaseUserFirebaseUserMetadata extends Mock implements FirebaseUserMetadata {
  DateTime get creationTime => DateTime.now();
  DateTime get lastSignInTime => DateTime.now();
}

void main() {
  Future<Widget> makeTestableWidget({Widget child, BaseAuthService auth}) async {
    final auth = MockFirebaseAuth(signedIn: true);
    FirebaseUser firebaseUser = await auth.currentUser();
    FirebaseUserMetadata metadata = MockFirebaseUserFirebaseUserMetadata();
    UserModel user = UserModel(firebaseUser: firebaseUser, email: 'tester@testing.com', photoUrl: 'https://via.placeholder.com/150', metadata: metadata);
    return Provider<UserModel>.value(
      value: user,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('test if page is the profile page', (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    ProfilePage page = ProfilePage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(await makeTestableWidget(child: page, auth: mockAuth));

    // Verify that the profile page is present.
    expect(find.byKey(Key('profile_page')), findsOneWidget);
  });

  testWidgets('test if profile page use user information class',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    UserInformation page = UserInformation();

    // Build our app and trigger a frame.
    await tester.pumpWidget(await makeTestableWidget(child: page, auth: mockAuth));

    // Verify that the profile page use user information class
    expect(find.byKey(Key('display_user')), findsOneWidget);
  });

  testWidgets('test if profile page has a cached network image',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    ProfilePage page = ProfilePage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(await makeTestableWidget(child: page, auth: mockAuth));
    var cachedNetworkImage = find.byType(CachedNetworkImage);

    // Verify that the profile page has a cachedNetworkImage.
    expect(cachedNetworkImage, findsOneWidget);
  });

  testWidgets('test if profile page has three icons',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    UserInformation page = UserInformation();

    // Build our app and trigger a frame.
    await tester.pumpWidget(await makeTestableWidget(child: page, auth: mockAuth));

    // Verify that the profile page has a circleAvatar.
    expect(find.byIcon(FontAwesomeIcons.user), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.envelope), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.home), findsOneWidget);
  });

  testWidgets('test if profile page has the two buttons: change-pw and logout',
          (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    ProfilePage page = ProfilePage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(await makeTestableWidget(child: page, auth: mockAuth));

    // Verify that the ProfilePage has a change password and a logout button.
    expect(find.byKey(Key('change-pw')), findsOneWidget);
    expect(find.byKey(Key('logout')), findsOneWidget);
  });
}

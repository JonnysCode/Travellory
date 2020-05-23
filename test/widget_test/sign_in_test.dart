import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:travellory/providers/auth_provider.dart';

import 'package:travellory/screens/authenticate/sign_in.dart';
import 'package:travellory/services/authentication/auth.dart';
import 'package:travellory/shared/loading_heart.dart';

class MockAuth extends Mock implements BaseAuthService {}

void main() {
  Widget makeTestableWidget({Widget child, BaseAuthService auth}) {
    return AuthProvider(
        auth: auth,
        child: MaterialApp(
          home: child,
          routes: {'/loadingLogo': (BuildContext context) => LoadingHeart()},
        ));
  }

  Future<void> prepareSignIn(String email, String password, WidgetTester tester) async {
    // Enter text into the fields and tap the sign in button
    Finder emailField = find.byKey(Key('emailField'));
    await tester.enterText(emailField, email);

    Finder passwordField = find.byKey(Key('passwordField'));
    await tester.enterText(passwordField, password);

    await tester.tap(find.byKey(Key('loginButton')));
  }

  testWidgets('test if widgets are present', (WidgetTester tester) async {
    SignIn page = SignIn();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that email field is present.
    expect(find.byKey(Key('emailField')), findsOneWidget);

    // Verify that password field is present.
    expect(find.byKey(Key('passwordField')), findsOneWidget);

    // Verify that sign in button is present.
    expect(find.byKey(Key('loginButton')), findsOneWidget);
  });

  testWidgets('email or password is empty, does not call sign in',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    SignIn page = SignIn();

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    verifyNever(mockAuth.signInWithEmailAndPassword('', ''));
  });

  testWidgets('non-empty non-valid email and password, does not call sign in',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    SignIn page = SignIn();

    // Invalid email address
    String email = 'sample@mail';
    String password = 'sampl3P8assword!';

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    await prepareSignIn(email, password, tester);

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // Verify that register does not get called
    verifyNever(mockAuth.signInWithEmailAndPassword(email, password));
  });

  testWidgets('non-empty email and non-valid password, does not call sign in',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    SignIn page = SignIn();

    // invalid email address
    String email = 'sample.email@bluewin.ch';
    String password = '123';

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    await prepareSignIn(email, password, tester);

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // Verify that sign in does not get called
    verifyNever(mockAuth.signInWithEmailAndPassword(email, password));
  });

  testWidgets('non-empty email and password, call sign in',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    SignIn page = SignIn();

    String email = 'sample.email@gmail.com';
    String password = 'sampl3P8assword!';

    // mock method register
    when(mockAuth.signInWithEmailAndPassword(email, password))
        .thenAnswer((_) => Future.value('Stub'));

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    await prepareSignIn(email, password, tester);

    // Verify that the sign in was called once
    verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);
  });
}

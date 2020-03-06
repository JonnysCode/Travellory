import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:travellory/providers/auth_provider.dart';

import 'package:travellory/screens/authenticate/sign_in.dart';
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

  testWidgets('test if widgets are present', (WidgetTester tester) async {
    SignIn page = SignIn();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that email field is present.
    expect(find.byKey(Key('emailField')), findsOneWidget);

    // Verify that password field is present.
    expect(find.byKey(Key('passwordField')), findsOneWidget);

    // Verify that sign in button is present.
    expect(find.byKey(Key('signInButton')), findsOneWidget);
  });

  testWidgets('email or password is empty, does not call sign in',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    SignIn page = SignIn();

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    verifyNever(mockAuth.signInWithEmailAndPassword('', ''));
  });

  testWidgets('non-empty email and password, call sign in',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    SignIn page = SignIn();

    String email = 'sample.email@gmail.com';
    String password = 'sampl3P8assword!';

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // Enter text into the fields and tap the sign in button
    Finder emailField = find.byKey(Key('emailField'));
    await tester.enterText(emailField, email);

    Finder passwordField = find.byKey(Key('passwordField'));
    await tester.enterText(passwordField, password);

    await tester.tap(find.byKey(Key('signInButton')));

    // Verify that the sign in was called once
    verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);
  });
}

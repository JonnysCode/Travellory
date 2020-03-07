import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:travellory/providers/auth_provider.dart';

import 'package:travellory/screens/authenticate/register.dart';
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

  prepareRegister(String email, String password, WidgetTester tester) async {
    // Enter text into the fields and tap the register button
    Finder emailField = find.byKey(Key('emailField'));
    await tester.enterText(emailField, email);

    Finder passwordField = find.byKey(Key('passwordField'));
    await tester.enterText(passwordField, password);

    await tester.tap(find.byKey(Key('registerButton')));
  }

  testWidgets('test if widgets are present', (WidgetTester tester) async {
    Register page = Register();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that email field is present.
    expect(find.byKey(Key('emailField')), findsOneWidget);

    // Verify that password field is present.
    expect(find.byKey(Key('passwordField')), findsOneWidget);

    // Verify that register button is present.
    expect(find.byKey(Key('registerButton')), findsOneWidget);
  });

  testWidgets('email or password is empty, does not call register',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    Register page = Register();

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // Verify that register does not get called
    verifyNever(mockAuth.registerWithEmailAndPassword('', ''));
  });

  testWidgets('non-empty non-valid email and password, does not call register',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    Register page = Register();

    // Invalid email address
    String email = 'sample@mail';
    String password = 'sampl3P8assword!';

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    await prepareRegister(email, password, tester);

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // Verify that register does not get called
    verifyNever(mockAuth.registerWithEmailAndPassword(email, password));
  });

  testWidgets('non-empty email and non-valid password, does not call register',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    Register page = Register();

    // invalid email address
    String email = 'sample.email@bluewin.ch';
    String password = '123';

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    await prepareRegister(email, password, tester);

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // Verify that register does not get called
    verifyNever(mockAuth.registerWithEmailAndPassword(email, password));
  });

  testWidgets('non-empty email and password, call register',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    Register page = Register();

    String email = 'sample.email@gmail.com';
    String password = 'sampl3P8assword!';

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    await prepareRegister(email, password, tester);

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // Verify that register was called once
    verify(mockAuth.registerWithEmailAndPassword(email, password)).called(1);
  });
}

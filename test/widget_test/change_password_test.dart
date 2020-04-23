import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:travellory/providers/auth_provider.dart';

import 'package:travellory/screens/authenticate/password.dart';
import 'package:travellory/services/authentication/auth.dart';
import 'package:travellory/shared/loading.dart';

class MockAuth extends Mock implements BaseAuthService {}

void main() {
  Widget makeTestableWidget({Widget child, BaseAuthService auth}) {
    return AuthProvider(
        auth: auth,
        child: MaterialApp(
          home: child,
          routes: {'/loading': (BuildContext context) => Loading()},
        ));
  }

  prepareChangePassword(
      String oldPassword, String newPassword, WidgetTester tester) async {
    // Enter text into the fields and tap the register button

    Finder oldPasswordField = find.byKey(Key('old passwordField'));
    await tester.enterText(oldPasswordField, oldPassword);

    Finder newPasswordField = find.byKey(Key('new passwordField'));
    await tester.enterText(newPasswordField, newPassword);

    await tester.tap(find.byKey(Key('saveButton')));
  }

  testWidgets('test if widgets are present', (WidgetTester tester) async {
    ChangePassword page = ChangePassword();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that old password field is present.
    expect(find.byKey(Key('old passwordField')), findsOneWidget);

    // Verify that new password field is present.
    expect(find.byKey(Key('new passwordField')), findsOneWidget);

    // Verify that save button is present.
    expect(find.byKey(Key('saveButton')), findsOneWidget);
  });

  testWidgets(
      'password fields are empty, does not call reauthenticate or change password',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    ChangePassword page = ChangePassword();

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // Verify that methods do not get called
    verifyNever(mockAuth.reauthenticate(''));
    verifyNever(mockAuth.changePassword(''));
  });

  testWidgets(
      'non-empty non-valid old password, does not call reauthenticate or change password',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    ChangePassword page = ChangePassword();

    // Invalid old password
    String oldPassword = '123';
    String newPassword = 'validPassword!!1';

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    await prepareChangePassword(oldPassword, newPassword, tester);

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // Verify that methods do not get called
    verifyNever(mockAuth.reauthenticate(oldPassword));
    verifyNever(mockAuth.changePassword(newPassword));
  });

  testWidgets('non-empty non-valid new password, does not call reauthenticate or change password',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    ChangePassword page = ChangePassword();

    // Invalid new password
    String oldPassword = 'validPassword!!1';
    String newPassword = '123';

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    await prepareChangePassword(oldPassword, newPassword, tester);

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // Verify that methods do not get called
    verifyNever(mockAuth.reauthenticate(oldPassword));
    verifyNever(mockAuth.changePassword(newPassword));
  });

  testWidgets('valid passwords, call reauthenticate and change password',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    ChangePassword page = ChangePassword();

    String oldPassword = 'validPassword!!1';
    String newPassword = 'validPassword!!2';

    // mock method reauthenticate
    when(mockAuth.reauthenticate(oldPassword))
        .thenAnswer((_) => Future.value('Stub'));

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    await prepareChangePassword(oldPassword, newPassword, tester);

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    // Advance time by 3 sec so that timer set by SnackBar finishes
    await tester.pumpAndSettle(Duration(seconds: 3));

    // Verify that methods were called once each
    verify(mockAuth.reauthenticate(oldPassword)).called(1);
    verify(mockAuth.changePassword(newPassword)).called(1);
  });
}

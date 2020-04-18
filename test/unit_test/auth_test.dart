import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:travellory/services/auth.dart';

class MockAuth extends Mock implements FirebaseAuth {}
class MockAuthResult extends Mock implements AuthResult {}
class MockFirebaseUser extends Mock implements FirebaseUser {}

void main() {
  testWidgets('test register with email and password',
      (WidgetTester tester) async {
    FirebaseAuth auth = MockAuth();
    AuthResult result = MockAuthResult();
    FirebaseUser user = MockFirebaseUser();

    AuthService authService = AuthService(auth: auth);

    await when(auth.createUserWithEmailAndPassword(
        email: 'email@email.com', password:'password'))
        .thenAnswer((_) async => result);
    
    when(result.user).thenReturn(user);
    await when(auth.currentUser()).thenThrow((e) {});

    await authService
        .registerWithEmailAndPassword(
            'email@email.com', 'password', 'displayName')
        .catchError((e) {});

    verify(auth.createUserWithEmailAndPassword(
        email: 'email@email.com', password: 'password'));
  });

  testWidgets('test sign in with email and password',
      (WidgetTester tester) async {
    FirebaseAuth auth = MockAuth();
    AuthService authService = AuthService(auth: auth);

    await authService
        .signInWithEmailAndPassword('email@email.com', 'password')
        .catchError((e) {});

    verify(auth.signInWithEmailAndPassword(
        email: 'email@email.com', password: 'password'));
  });

  testWidgets('test getting current user', (WidgetTester tester) async {
    FirebaseAuth auth = MockAuth();
    AuthService authService = AuthService(auth: auth);

    await authService.getCurrentUser();

    verify(auth.currentUser());
  });

  testWidgets('test sign in anonym', (WidgetTester tester) async {
    FirebaseAuth auth = MockAuth();
    AuthService authService = AuthService(auth: auth);

    await authService.signInAnonymously();

    verify(auth.signInAnonymously());
  });

  testWidgets('test sign out', (WidgetTester tester) async {
    FirebaseAuth auth = MockAuth();
    AuthService authService = AuthService(auth: auth);

    await authService.signOut();

    verify(auth.signOut());
  });
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:travellory/services/auth.dart';

class MockAuth extends Mock implements FirebaseAuth {}

void main() {

  testWidgets('test register with email and password', (WidgetTester tester) async {

    FirebaseAuth auth = MockAuth();
    AuthService authService = AuthService(auth: auth);

    await authService.registerWithEmailAndPassword('email@email.com', 'password', 'displayName');

    verify(auth.createUserWithEmailAndPassword(email: 'email@email.com', password: 'password'));
  });

  testWidgets('test sign in with email and password', (WidgetTester tester) async {

    FirebaseAuth auth = MockAuth();
    AuthService authService = AuthService(auth: auth);

    await authService.signInWithEmailAndPassword('email@email.com', 'password');

    verify(auth.signInWithEmailAndPassword(email: 'email@email.com', password: 'password'));
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

  testWidgets('test update photoUrl', (WidgetTester tester) async {

    FirebaseAuth auth = MockAuth();
    AuthService authService = AuthService(auth: auth);

    String photoUrl = 'https://via.placeholder.com/150';
    await authService.updatePhotoUrl(photoUrl);

    verify(authService.updatePhotoUrl(photoUrl));
  });

}
import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/src/models/user_model.dart';
import 'package:travellory/src/providers/auth_provider.dart';
import 'package:travellory/src/screens/main/profile_page.dart';
import 'package:travellory/src/services/authentication/auth.dart';
import 'package:travellory/src/utils/image_picker_handler.dart';
import 'package:travellory/src/components/buttons/buttons.dart';
import 'package:travellory/src/components/shared/font_widgets.dart';
import 'package:travellory/src/components/dialogs/image_picker_dialog.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

import 'profile_page_test.dart';

void main() {
  Widget makeTestableWidget({Widget child, BaseAuthService auth}) {
    return AuthProvider(
        auth: auth,
        child: MaterialApp(
          home: child,
        ));
  }

  Future<Widget> makeTestableWidgetForProfilePage({Widget child, BaseAuthService auth}) async {
    final auth = MockFirebaseAuth(signedIn: true);
    FirebaseUser firebaseUser = await auth.currentUser();
    FirebaseUserMetadata metadata = MockFirebaseUserFirebaseUserMetadata();
    UserModel user = UserModel(firebaseUser: firebaseUser, email: 'tester@testing.com', photoUrl: 'https://via.placeholder.com/25', metadata: metadata);
    return Provider<UserModel>.value(
      value: user,
      child: MaterialApp(
        home: Scaffold(body: child),
      ),
    );
  }

  testWidgets('test if page has the select menu widget',
          (WidgetTester tester) async {
        MockAuth mockAuth = MockAuth();
        ImagePickerHandler _listener;
        AnimationController _controller;
        ImagePickerDialog page = ImagePickerDialog(_listener, _controller);

        // Build our app and trigger a frame.
        await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

        // Verify that the selection menu is present.
        expect(find.byKey(Key('selection_menu')), findsOneWidget);
      });

  testWidgets('test if page has three GestureDetector',
          (WidgetTester tester) async {
        MockAuth mockAuth = MockAuth();
        ImagePickerHandler _listener;
        AnimationController _controller;
        ImagePickerDialog page = ImagePickerDialog(_listener, _controller);

        // Build our app and trigger a frame.
        await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));
        var gestureDetector = find.byType(GestureDetector);

        // Verify that the profile page has three GestureDetector
        expect(gestureDetector, findsNWidgets(3));
      });

  testWidgets('test if page has three FashionFetishTexts',
          (WidgetTester tester) async {
        MockAuth mockAuth = MockAuth();
        ImagePickerHandler _listener;
        AnimationController _controller;
        ImagePickerDialog page = ImagePickerDialog(_listener, _controller);

        // Build our app and trigger a frame.
        await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));
        var fashionFetishText = find.byType(FashionFetishText);

        // Verify that the profile page has three FashionFetishText
        expect(fashionFetishText, findsNWidgets(3));
        expect(find.text('Take Photo'), findsOneWidget);
        expect(find.text('Choose from Library'), findsOneWidget);
        expect(find.text('Cancel'), findsOneWidget);
      });

  testWidgets('test if page pick image', (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    Widget page = ProfilePage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(await makeTestableWidgetForProfilePage(child: page, auth: mockAuth));
    await tester.tap(find.byKey(Key('image_pick')));
    await tester.pump();

    // Verify that the page pick image
    expect(find.byKey(Key('selection_menu')), findsOneWidget);
  });

  testWidgets('test', (WidgetTester tester) async {
    AnimationController _controllerHandler;
    ImagePickerListener _listenerHandler;
    final listener = ImagePickerHandler(_listenerHandler, _controllerHandler);

    Widget makeTestableWidget() {
      return MaterialApp(
          home: Material(child: Builder(builder: (BuildContext context) {
            return Center(
              child: GestureDetector(
                key: Key('gallery_key'),
                onTap: () => listener.openGallery(),
                child: roundedButton(
                    'Choose from Library',
                    EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                    Theme.of(context).primaryColor,
                    const Color(0xFFFFFFFF)),
              ),
            );
          })));
    }

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byKey(Key('gallery_key')), findsOneWidget);
  });

  testWidgets('test if open Gallery method has ben called',
          (WidgetTester tester) async {
        final test = MockImagePickerHandler();

        when(test.openGallery()).thenReturn(null);
        test.openGallery();
        verify(test.openGallery()).called(1);
      });

  testWidgets('test if open Camera method has ben called',
          (WidgetTester tester) async {
        final test = MockImagePickerHandler();

        when(test.openCamera()).thenReturn(null);
        test.openCamera();
        verify(test.openCamera()).called(1);
      });

  testWidgets('test if crop image method has ben called',
          (WidgetTester tester) async {
        final test = MockImagePickerHandler();
        final image = File('assets/photo_camera.png');

        when(test.cropImage(image)).thenReturn(null);
        await test.cropImage(image);
        verify(test.cropImage(image)).called(1);
      });
}

class MockImagePickerHandler extends Mock implements ImagePickerHandler {}
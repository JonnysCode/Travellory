

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/screens/home/pages/profile_page.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/utils/image_picker_handler.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/image_picker_dialog.dart';

import 'profile_page_test.dart';

void main() {
  Widget makeTestableWidget({Widget child, BaseAuthService auth}) {
    return AuthProvider(
        auth: auth,
        child: MaterialApp(
          home: child,
        ));
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

  testWidgets('test if page has three gesture detector',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    ImagePickerHandler _listener;
    AnimationController _controller;
    ImagePickerDialog page = ImagePickerDialog(_listener, _controller);

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));
    var gestureDetector = find.byType(GestureDetector);

    // Verify that the profile page has three gesture detectors
    expect(gestureDetector, findsNWidgets(3));
  });

  testWidgets('test if page has three FashionfetishTexts',
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
    expect(find.text("Take Photo"), findsOneWidget);
    expect(find.text("Choose from Library"), findsOneWidget);
    expect(find.text("Cancel"), findsOneWidget);
  });

  testWidgets('test if page has three FashionfetishTexts',
      (WidgetTester tester) async {
        MockAuth mockAuth = MockAuth();
   Widget page = ProfilePage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page,auth: mockAuth));
    await tester.tap(find.byKey(Key('image_pick')));
    await tester.pump();
    // Verify that the profile page has three FashionFetishText
        expect(find.byKey(Key('selection_menu')), findsOneWidget);
    //expect(find.byWidget(SlideTransition(),skipOffstage: false), isOffstage);
  });
}
/*

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper>   with TickerProviderStateMixin, ImagePickerListener {

  ImagePickerHandler imagePicker;
  AnimationController _controller;



  void initState() {

    super.initState();
    _controller =  AnimationController(
      duration: const Duration(milliseconds: 500),
    );
    imagePicker =  ImagePickerHandler(this, _controller);
    imagePicker.init();

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> imagePickerDialog.getImage(context),
      child: SizedBox.expand(key: Key('wrapper'),),
    );


  }
}
*/


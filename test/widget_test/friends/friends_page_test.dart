import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/friends_provider.dart';
import 'package:travellory/screens/home/pages/friends_page.dart';
import 'package:travellory/services/authentication/auth.dart';

class MockAuth extends Mock implements BaseAuthService {}

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<FriendsProvider>(
          create: (context) => FriendsProvider()
          ),
          StreamProvider<UserModel>.value(
          value: MockAuth().user
          ),
        ],
        child: MaterialApp(
            home: child
        ));
  }

  testWidgets('test if page is the friends page', (WidgetTester tester) async {
    FriendsPage page = FriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the friends page is present.
    expect(find.byKey(Key('friends_page')), findsOneWidget);
  });
}

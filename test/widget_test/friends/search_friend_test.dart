import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/screens/friends/create_search_friend_screen.dart';

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('test if search friend page is present', (WidgetTester tester) async {
    Widget page = SearchFriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that map container is present.
    expect(find.byKey(Key('search_friends')), findsOneWidget);
  });

  testWidgets('test if search friend page has searchbar', (WidgetTester tester) async {
    Widget page = SearchFriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));
    //var searchBar = find.byType(SearchBar);

    // Verify that map container is present.
    expect(find.byKey(Key('search_bar')), findsOneWidget);
    expect(find.byType(SearchBar, skipOffstage: false), isOffstage);
  });


  testWidgets('test if search friend page has back button', (WidgetTester tester) async {
    Widget page = SearchFriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));
    var backIcon = find.byIcon(Icons.arrow_back);

    // Verify that map container is present.
    expect(find.byKey(Key('search_bar')), findsOneWidget);
    expect(backIcon, findsOneWidget);
  });

  testWidgets('test if search friend page has searchIcon, Cancel Text, hintText' , (WidgetTester tester) async {
    Widget page = SearchFriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));
    var textAddFriends = find.text('Add friends');
    var textCancel = find.text('Cancel');
    var searchIcon = find.byIcon(Icons.search);

    // Verify that map container is present.
    expect(textAddFriends, findsOneWidget);
    expect(textCancel, findsOneWidget);
    expect(searchIcon, findsOneWidget);
  });
}
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/providers/screens/friends_page_provider.dart';

class Post {
  final String title;

  Post(this.title);
}

class SearchFriendsPage extends StatefulWidget {
  @override
  _SearchFriendsPageState createState() => _SearchFriendsPageState();
}

class _SearchFriendsPageState extends State<SearchFriendsPage> {
  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 1));
    return List.generate(search.length, (int index) {
      return Post(
        'Username : $search $index',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
            key: Key('search_friends'),
            child: Column(
              children: <Widget>[
                Container(
                  height: 80,
                  child: Row(children: [
                    Container(
                      child: IconButton(
                        onPressed: () => Provider.of<FriendsPageProvider>(context, listen: false).toggleSearching(),
                        icon: Icon(FontAwesomeIcons.arrowLeft),
                        iconSize: 28,
                        color: Colors.black38,
                      ),
                    ),
                    Expanded(
                      child: SearchBar(
                          key: Key('search_bar'),
                          onSearch: search,
                          onItemFound: (Post post, int index) {
                            return ListTile(
                              title: Text(post.title),
                            );
                          },
                          searchBarPadding:
                              EdgeInsets.fromLTRB(0, 0, 10, 0),
                          headerPadding:
                              EdgeInsets.symmetric(horizontal: 50),
                          listPadding:
                              EdgeInsets.symmetric(horizontal: 30),
                          hintText: 'Add friends',
                          hintStyle: TextStyle(
                            color: Colors.black45,
                          ),
                          icon: Icon(
                            FontAwesomeIcons.search,
                            size: 24.0,
                          ),
                          iconActiveColor: Colors.black54,
                          searchBarStyle: SearchBarStyle(
                            backgroundColor: Colors.black12,
                            padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          cancellationWidget: Text(
                            'Cancel',
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ]),
                ),
                Expanded(
                  child: Container(
                    // TODO LIST Stuff
                  )
                ),
              ],
            ));
  }
}

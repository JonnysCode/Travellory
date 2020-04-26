import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:travellory/screens/home/pages/friends_page.dart';

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
    return Scaffold(
        body: SafeArea(
            key: Key('search_friends'),
            child: Stack(children: <Widget>[
              SizedBox.expand(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(6, 40, 6, 0),
                      child: Container(
                          alignment: AlignmentDirectional(-1, -1),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(40.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 20,
                                  color: Colors.black.withOpacity(.2),
                                  offset: Offset(0.0, -6.0))
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(40.0)),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 20,
                                    color: Colors.black.withOpacity(.2),
                                    offset: Offset(0.0, -6.0))
                              ],
                            ),
                            constraints: BoxConstraints(
                              maxHeight: 80.0,
                              maxWidth: 365.0,
                            ),
                            child: Row(children: [
                              Container(
                                child: IconButton(
                                  onPressed: () => {
                                    setState(() {
                                      isSearch = false;
                                    })
                                  },

                                  /* Navigator.pop(context)},*/
                                  icon: Icon(Icons.arrow_back),
                                  iconSize: 30,
                                  color: Colors.black,
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
                                      color: Colors.grey[800],
                                    ),
                                    icon: Icon(
                                      Icons.search,
                                      size: 30.0,
                                    ),
                                    searchBarStyle: SearchBarStyle(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      padding: EdgeInsets.all(5),
                                    ),
                                    cancellationWidget: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ]),
                          ))))
            ])));
  }
}

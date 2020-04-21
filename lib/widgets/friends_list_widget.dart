import 'package:flutter/material.dart';
import 'package:travellory/models/friends_model.dart';

Widget friendList(Key key, List<FriendsModel> list, BuildContext context) {
  return Padding(
    key: key,
    padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom),
    child: Column(
        children: <Widget>[
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemExtent: 35,
              padding: EdgeInsets.only(
                  bottom: 20
              ),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${list[index].username}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              },
            ),
          ),
        ]
    ),
  );
}
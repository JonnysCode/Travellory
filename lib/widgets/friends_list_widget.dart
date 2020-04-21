import 'package:flutter/material.dart';
import 'package:travellory/models/friends_model.dart';

Widget friendList(Key key, List<FriendsModel> list, Widget trailing, BuildContext context) {
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
              padding: EdgeInsets.only(
                bottom: 50,
              ),
              scrollDirection: Axis.vertical,
              itemExtent: 40,
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: friendBoxDecoration(),
                  height: 50,
                  child: ListTile(
                    title: Text(
                      '${list[index].username}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        height: 0,
                      ),
                    ),
                    trailing: trailing
                  ),
                );
              },
            ),
          ),
        ]
    ),
  );
}

BoxDecoration friendBoxDecoration() {
  return BoxDecoration(
    border: Border(
        bottom: BorderSide(
            color: Colors.grey,
            width: 0.3,
            style: BorderStyle.solid
        )
    ),
  );
}
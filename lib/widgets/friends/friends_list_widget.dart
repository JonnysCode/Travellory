import 'package:flutter/material.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/widgets/buttons/option_button.dart';
import 'package:travellory/widgets/friends/friends_card_widget.dart';

Widget friendList(Key key, double height, List<FriendsModel> list, OptionButton button, BuildContext context) {
  return Padding(
    key: key,
    padding: EdgeInsets.only(
        left: 15,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom),
    child: Column(
        children: <Widget>[
          Container(
            height: height,
            child: Scrollbar(
              child: ListView.separated(
                padding: EdgeInsets.only(
                  bottom: 50,
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return friendsCard(context, list, button, index);
                },
              ),
            ),
          ),
        ]
    ),
  );
}
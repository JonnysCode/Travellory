import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({
    Key key,
    this.optionItems,
  }) : super(key: key);

  final List<OptionItem> optionItems;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 16,
        child: PopupMenuButton<OptionItem>(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
          ),
          onSelected: (OptionItem option) => option.onTab,
          itemBuilder: (_) => optionItems.map((optionItem) =>
              PopupMenuItem<OptionItem>(
                child: ListTile(
                  leading: Icon(
                    optionItem.icon,
                    color: optionItem.color,
                  ),
                  title: Text(
                    optionItem.description,
                    style: TextStyle(
                      color: optionItem.color,
                      fontSize: 18
                    ),
                  ),
                ),
              )).toList(),
          icon: Icon(
            FontAwesomeIcons.ellipsisV,
            color: Colors.black54,
          ),
        )
    );
  }
}

class OptionItem{
  const OptionItem({
    @required this.icon,
    @required this.description,
    this.onTab,
    this.color,
  });

  final IconData icon;
  final String description;
  final Function onTab;
  final Color color;
}
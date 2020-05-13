import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({
    Key key,
    this.optionItems,
    this.icon = FontAwesomeIcons.ellipsisV,
  }) : super(key: key);

  final List<OptionItem> optionItems;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 16,
        child: PopupMenuButton<OptionItem>(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
          ),
          itemBuilder: (_) => optionItems.map((optionItem) =>
              PopupMenuItem<OptionItem>(
                child: ListTile(
                  onTap: optionItem.onTab,
                  leading: optionItem.icon != null
                      ? Icon(
                        optionItem.icon,
                        color: optionItem.color,
                      )
                      : null,
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
            icon,
            color: Colors.black54,
          ),
        )
    );
  }
}

class OptionItem{
  const OptionItem({
    @required this.description,
    this.icon,
    this.onTab,
    this.color,
  });

  final IconData icon;
  final String description;
  final Function onTab;
  final Color color;
}
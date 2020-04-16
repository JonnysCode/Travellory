import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key key,
    @required this.child,
    this.color,
    this.onTab
  }) : super(key : key);

  final Color color;
  final Widget child;
  final Function onTab;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => onTab,
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: color == null ? Colors.grey : color,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(.2), offset: Offset(0.0, 6.0))
          ],
        ),
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FormItem extends StatelessWidget {
  const FormItem({Key key, @required this.animation, @required this.child})
      : assert(animation != null),
        assert(child != null),
        super(key: key);

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: SizeTransition(axis: Axis.vertical, sizeFactor: animation, child: child),
    );
  }
}

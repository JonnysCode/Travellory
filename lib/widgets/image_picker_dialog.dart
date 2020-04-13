import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travellory/utils/image_picker_handler.dart';

import 'font_widgets.dart';

class ImagePickerDialog extends StatelessWidget {
  ImagePickerDialog(this._listener, this._controller);

  final ImagePickerHandler _listener;
  final AnimationController _controller;
  BuildContext context;

  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;

  void initState() {
    _drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  getImage(BuildContext context) {
    if (_controller == null ||
        _drawerDetailsPosition == null ||
        _drawerContentsOpacity == null) {
      return;
    }
    _controller.forward();
    showDialog(
      context: context,
      builder: (BuildContext context) => SlideTransition(
        position: _drawerDetailsPosition,
        child: FadeTransition(
          opacity: ReverseAnimation(_drawerContentsOpacity),
          child: this,
        ),
      ),
    );
  }

  void dispose() {
    _controller.dispose();
  }

  startTime() async {
    final _duration = Duration(milliseconds: 200);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pop(context);
  }

  void dismissDialog() {
    _controller.reverse();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Material(
        key: Key('selection_menu'),
        type: MaterialType.transparency,
        child: Opacity(
          opacity: 1.0,
          child: Container(
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  key: Key('camera_key'),
                  onTap: () => _listener.openCamera(),
                  child: roundedButton(
                      'Take Photo',
                      EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                      Theme.of(context).primaryColor,
                      const Color(0xFFFFFFFF)),
                ),
                GestureDetector(
                  key: Key('gallery_key'),
                  onTap: () => _listener.openGallery(),
                  child: roundedButton(
                      'Choose from Library',
                      EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                      Theme.of(context).primaryColor,
                      const Color(0xFFFFFFFF)),
                ),
                const SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () => dismissDialog(),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(60.0, 0.0, 60.0, 0.0),
                    child: roundedButton(
                        'Cancel',
                        EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        Colors.red,
                        const Color(0xFFFFFFFF)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget roundedButton(
      String buttonLabel, EdgeInsets margin, Color bgColor, Color textColor) {
    var loginBtn = Container(
      margin: margin,
      padding: EdgeInsets.all(15.0),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(const Radius.circular(100.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: FashionFetishText(
        text: buttonLabel,
        size: 20,
        color: Colors.white,
        fontWeight: FashionFontWeight.normal,
        height: 1.05,
      ),
    );
    return loginBtn;
  }
}

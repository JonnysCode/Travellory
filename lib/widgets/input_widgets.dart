import 'package:flutter/material.dart';

Widget inputAuthentication(Icon icon, String hint, Color decorationColor, TextEditingController controller,
    bool obsecure) {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20),
    child: TextField(
      controller: controller,
      obscureText: obsecure,
      style: TextStyle(
        fontSize: 20,
      ),
      decoration: InputDecoration(
          hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: decorationColor,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: decorationColor,
              width: 3,
            ),
          ),
          prefixIcon: Padding(
            child: IconTheme(
              data: IconThemeData(color: decorationColor),
              child: icon,
            ),
            padding: EdgeInsets.only(left: 30, right: 10),
          )),
    ),
  );
}
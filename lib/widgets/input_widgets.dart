import 'package:flutter/material.dart';
import 'package:travellory/utils/input_validator.dart';

Widget inputAuthentication(Icon icon, String hint, Color decorationColor, TextEditingController controller,
    ValidatorType validatorType, bool obscure) {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20),
    child: TextFormField(
      key: Key(hint.toLowerCase().trim() + 'Field'),
      controller: controller,
      obscureText: obscure,
      validator: (val) => InputValidator.validate(val, validatorType),
      style: TextStyle(
        fontSize: 20,
      ),
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
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
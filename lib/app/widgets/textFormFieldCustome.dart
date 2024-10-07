import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textFormFieldCustom(String hintValue, String labelValue, TextEditingController controller, {bool isPassword = false, bool isEmail = false}) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      hintText: hintValue,
      labelText: labelValue,
      labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'This field is required';
      } else if (isEmail && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        return 'Please enter a valid email';
      } else if (isPassword && value.length < 6) {
        return 'Password must be at least 6 characters long';
      }
      return null;

    },
  );
}

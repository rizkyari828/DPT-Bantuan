import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/shared/constants/colors.dart';
import 'package:flutter_getx_boilerplate/shared/constants/common.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final String placeholder;
  final Color color;
  final double fontSize;
  final bool password;
  final String? Function(String?)? validator;

  InputField({
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.labelText = '',
    this.placeholder = '',
    this.color = Colors.white,
    this.fontSize = CommonConstants.bodyText,
    this.password = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.backgroundTextField,
      elevation: 0.1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: color),
            borderRadius: BorderRadius.circular(15),
          ),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: this.placeholder,
          hintStyle: TextStyle(
            fontSize: fontSize,
            // color: color,
            fontWeight: FontWeight.normal,
          ),
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          // labelStyle: TextStyle(
          //   fontSize: fontSize - 2,
          //   color: color,
          //   height: 0.2,
          //   fontWeight: FontWeight.normal,
          // ),
        ),
        controller: this.controller,
        style: TextStyle(
          // color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
        ),
        keyboardType: this.keyboardType,
        obscureText: this.password,
        autocorrect: false,
        validator: this.validator,
      ),
    );
  }
}


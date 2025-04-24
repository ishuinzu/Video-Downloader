import 'package:flutter/material.dart';
import '../main.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  TextInputAction? inputAction = TextInputAction.next;

  final bool obscureText;
  Function(String value)? onChanged;

  TextFieldWidget({Key? key, required this.hintText, required this.prefixIconData, required this.suffixIconData, required this.obscureText, this.onChanged, this.inputAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: inputAction,
      onChanged: onChanged,
      obscureText: obscureText,
      cursorColor: theme.myAppMainColor,
      style: TextStyle(
        color: theme.myAppMainColor,
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: theme.myAppMainColor,
        ),
        focusColor: theme.myAppMainColor,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: theme.myAppMainColor,
          ),
        ),
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: theme.myAppMainColor,
        ),
        suffixIcon: GestureDetector(
          onTap: () {},
          child: Icon(
            suffixIconData,
            size: 18,
            color: theme.myAppMainColor,
          ),
        ),
      ),
    );
  }
}

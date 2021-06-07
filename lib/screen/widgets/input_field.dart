import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const CustomInputField({required this.controller, this.hint = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black),
            contentPadding: EdgeInsets.only(bottom: 13),
          ),
        ),
      ),
    );
  }
}

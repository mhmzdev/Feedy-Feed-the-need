import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData leadingIcon;
  final TextInputType textInputType;
  final bool obsecureText;
  final TextEditingController textEditingController;

  CustomTextField(
      {this.leadingIcon,
      this.labelText,
      this.textInputType,
      this.obsecureText,
      this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.065,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 5.0,
                color: Color(0xff264768).withAlpha(100),
                offset: Offset(2, 2))
          ],
          borderRadius: BorderRadius.circular(8.0)),
      child: Center(
        child: TextField(
          controller: textEditingController,
          keyboardType: textInputType,
          obscureText: obsecureText,
          style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.02),
          onChanged: (v) {
            print(v);
          },
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Color(0xff264768)),
            border: InputBorder.none,
            hintText: labelText,
            icon: Icon(
              leadingIcon,
            ),
          ),
        ),
      ),
    );
  }
}

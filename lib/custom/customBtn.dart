import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final Widget child;
  final VoidCallback onPress;

  CustomBtn({@required this.child, @required this.onPress});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: child,
      onPressed: onPress,
      color: Color(0xff264768),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }
}

import 'package:feedy_user/screens/customer/custHome.dart';
import 'package:feedy_user/screens/organization/orgHome.dart';
import 'package:feedy_user/screens/restaurants/restHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String userType;

  const HomeScreen({Key key, this.userType}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userEmail = "";

  String _getEmail() {
    User user = FirebaseAuth.instance.currentUser;
    String email = user.email;
    print("UESR EMAIL :::::: $email");
    return email;
  }

  void initState() {
    userEmail = _getEmail();
    super.initState();
  }

  Widget _userInterface(String uType) {
    if (uType == "Customer") {
      return CustomerHome();
    } else if (uType == "Restaurant") {
      return RestHome(
        restEmail: userEmail,
      );
    } else {
      return OrgHome();
    }
  }

  @override
  Widget build(BuildContext context) => _userInterface(widget.userType);
}

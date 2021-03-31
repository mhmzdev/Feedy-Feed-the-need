import 'package:feedy_user/screens/homeScreen.dart';
import 'package:feedy_user/screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _userType = "Customer";
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomeScreen();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(userType: _userType),
            ),
          );
        },
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/app/main.png',
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Who are you?",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.025,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Card(
                color: Color(0xff264768),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height * 0.022),
                    dropdownColor: Color(0xff264768),
                    iconEnabledColor: Colors.white,
                    underline: Container(),
                    isExpanded: true,
                    value: _userType,
                    items:
                        ["Customer", "Restaurant", "Organization"].map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Center(child: Text(value)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _userType = value;
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

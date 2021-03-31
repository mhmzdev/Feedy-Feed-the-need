import 'package:feedy_user/auth_service.dart';
import 'package:feedy_user/custom/customBtn.dart';
import 'package:feedy_user/custom/customTextField.dart';
import 'package:feedy_user/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final emailTextEditingController = TextEditingController();
final passwordTextEditingController = TextEditingController();

class LoginScreen extends StatefulWidget {
  final String userType;
  LoginScreen({@required this.userType});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String isSignedIn = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: FloatingActionButton(
            mini: true,
            child: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
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
                height: 50.0,
              ),
              CustomTextField(
                textEditingController: emailTextEditingController,
                labelText: "Enter Email",
                leadingIcon: Icons.mail,
                obsecureText: false,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 15.0,
              ),
              CustomTextField(
                textEditingController: passwordTextEditingController,
                labelText: "Enter Password",
                leadingIcon: Icons.lock,
                obsecureText: true,
                textInputType: TextInputType.text,
              ),
              SizedBox(
                height: 25.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.06,
                child: CustomBtn(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.015),
                    ),
                    onPress: () async {
                      isSignedIn = await context.read<AuthService>().signIn(
                            emailTextEditingController.text.trim(),
                            passwordTextEditingController.text.trim(),
                          );
                      emailTextEditingController.clear();
                      passwordTextEditingController.clear();
                      isSignedIn == "sin"
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HomeScreen(
                                  userType: widget.userType,
                                ),
                              ),
                            )
                          : print("ERRRRRRR");
                    }),
              ),
              SizedBox(
                height: 10.0,
              ),
              widget.userType == "Customer" ? NewAccountOption() : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class NewAccountOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("New Here?"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: InkWell(
            child: Text(
              "Register Now!",
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.0),
            ),
            onTap: () {},
          ),
        )
      ],
    );
  }
}

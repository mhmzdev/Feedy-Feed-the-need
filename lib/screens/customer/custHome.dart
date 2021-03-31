import 'package:feedy_user/auth_service.dart';
import 'package:feedy_user/screens/customer/menuScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerHome extends StatefulWidget {
  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  String _restaurantName = "Savour - College Road";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // User user = FirebaseAuth.instance.currentUser;
    // print("USER LOGGED IN ID:::::::::::${user.uid}");
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.read<AuthService>().signOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Choose the Restaurant/Place",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                width: width * 0.8,
                height: height * 0.07,
                child: Card(
                  color: Color(0xff264768),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      style: TextStyle(
                          color: Colors.white, fontSize: height * 0.022),
                      dropdownColor: Color(0xff264768),
                      iconEnabledColor: Colors.white,
                      underline: Container(),
                      isExpanded: true,
                      value: _restaurantName,
                      items: [
                        "Savour - College Road",
                        "14th Street Pizza",
                        "Khabby ki Sajji - F10",
                        "Savour - Blue Area",
                        "What'a Paratha - F7",
                        "Kukroon Kuroon - Royal Avenue",
                        "Chai Mehfi - F6"
                      ].map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Center(
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _restaurantName = value;
                        });
                        print(_restaurantName);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                child: MaterialButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MenuScreen(
                        restaurantName: _restaurantName,
                      ),
                    ),
                  ),
                  child: Text(
                    "Proceed",
                    style: TextStyle(
                      color: Color(0xff264768),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

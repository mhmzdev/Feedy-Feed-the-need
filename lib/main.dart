import 'package:feedy_user/auth_service.dart';
import 'package:feedy_user/screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// Color(0xff264768)
// Color(0xffed3031)

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthService>(
              create: (_) => AuthService(FirebaseAuth.instance)),
          StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges,
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            MediaQuery.of(context);
            return Theme(
              child: child,
              data: ThemeData(
                primaryColor: Color(0xff264768),
                accentColor: Color(0xff264768),
                cursorColor: Color(0xff264768),
                textTheme: TextTheme(
                  headline1: TextStyle(
                      color: Color(0xff264768),
                      fontSize: MediaQuery.of(context).size.height * 0.055,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.5),
                  headline2: TextStyle(
                      color: Color(0xff264768),
                      fontSize: MediaQuery.of(context).size.height * 0.035,
                      letterSpacing: 1.5),
                  bodyText1: TextStyle(
                    color: Color(0xff264768),
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                  ),
                  bodyText2: TextStyle(
                      color: Color(0xff264768),
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      letterSpacing: 1),
                  caption: TextStyle(
                    color: Color(0xff264768),
                    letterSpacing: 1.5,
                  ),
                ),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
            );
          },
          home: WelcomeScreen(),
        ));
  }
}

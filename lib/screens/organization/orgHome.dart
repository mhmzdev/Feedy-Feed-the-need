import 'package:feedy_user/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    );
  }
}

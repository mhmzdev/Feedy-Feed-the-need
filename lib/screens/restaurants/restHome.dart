import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedy_user/auth_service.dart';
import 'package:feedy_user/screens/restaurants/editItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestHome extends StatefulWidget {
  final String restEmail;

  const RestHome({Key key, this.restEmail}) : super(key: key);

  @override
  _RestHomeState createState() => _RestHomeState();
}

class _RestHomeState extends State<RestHome> {
  var restName;
  _getRestName() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(widget.restEmail)
        .get();
    String name = await doc['rName'];
    print("REST NAME:::::: $name");
    setState(() {
      restName = name;
    });
    return name;
  }

  @override
  void initState() {
    _getRestName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(restName.toString()),
        leading: BackButton(
          onPressed: () {
            context.read<AuthService>().signOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('restaurants')
            .doc(widget.restEmail)
            .collection('rMenu')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data.docs.map((doc) {
                return Card(
                  child: ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EditItem(
                          doc: doc,
                        ),
                      ),
                    ),
                    title: Text(doc['iName']),
                    trailing: Text("Rs: ${doc['iPrice']}"),
                  ),
                );
              }).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

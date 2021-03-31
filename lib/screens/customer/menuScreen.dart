import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedy_user/screens/customer/uploadPic.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  final String restaurantName;

  const MenuScreen({Key key, this.restaurantName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantName),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('restaurants')
            .doc(restaurantName)
            .collection('rMenu')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data.docs.map(
                (doc) {
                  return Card(
                    child: ListTile(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => UploadPic(
                            restaurantName: restaurantName,
                            doc: doc,
                          ),
                        ),
                      ),
                      title: Text(doc['iName']),
                      trailing: Text("Rs: ${doc['iPrice']}"),
                    ),
                  );
                },
              ).toList(),
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

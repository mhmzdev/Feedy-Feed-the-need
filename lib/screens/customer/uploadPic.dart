import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPic extends StatefulWidget {
  final doc;
  final String restaurantName;

  const UploadPic({Key key, this.doc, this.restaurantName}) : super(key: key);

  @override
  _UploadPicState createState() => _UploadPicState();
}

class _UploadPicState extends State<UploadPic> {
  FirebaseStorage _storage = FirebaseStorage.instance;
  ImagePicker picker = ImagePicker();
  String imageURL = "";
  File image;

  bool loading = false;
  bool imageSelected = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.upload_file),
        onPressed: _addImage,
      ),
      appBar: AppBar(
        title: Text("Upload"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.doc['iName'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "Rs: ${widget.doc['iPrice']}",
            ),
            Text(
              "Discount: ${widget.doc['iDiscount']}%",
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              width: width * 0.6,
              height: height * 0.06,
              child: MaterialButton(
                shape: StadiumBorder(),
                onPressed: _getImage,
                child: Text(
                  "Take a Photo",
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(0xff264768),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      print("NO IMAGE SELECTED");
      return;
    }
  }

  _addImage() async {
    if (image != null) {
      Reference reference =
          _storage.ref().child("images/${'image' + DateTime.now().toString()}");
      UploadTask uploadTask = reference.putFile(image);

      TaskSnapshot taskSnapshot = await uploadTask;
      String url = await taskSnapshot.ref.getDownloadURL();

      imageURL = url;
    }

    String doc = DateTime.now().toString();
    print(":::::::::::::: ${widget.restaurantName}");
    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(widget.restaurantName)
        .collection('discountAvail')
        .doc(doc)
        .set({
      "id": doc,
      "pic": imageURL ?? "empty",
    }).whenComplete(() {
      loading = false;

      Navigator.pop(context);
      print(":::::::::::::::::: IMAGE UPLOADED!");
    });
  }
}

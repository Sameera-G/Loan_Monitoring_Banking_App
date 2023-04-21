//this is ok for uploaded images

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lconst/model/user_model.dart';

class UploadedImg extends StatefulWidget {
  const UploadedImg({Key? key}) : super(key: key);

  @override
  State<UploadedImg> createState() => _UploadedImgState();
}

class _UploadedImgState extends State<UploadedImg> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String? downloadUrl;

  @override
  void initState() {
    //implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uploaded Images'),
      ),
      body: //show images *****************************************
          Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(loggedInUser.uid)
                .collection('progress_images')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return (const Center(
                  child: Text('No Image Uploaded'),
                ));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      String url = snapshot.data!.docs[index]['downloadURL1'];
                      return Image.network(
                        url,
                        height: 300.0,
                        fit: BoxFit.cover,
                      );
                    });
              }
            }
            //profile information tables finished here
            ),
      ),
    );
  }
}

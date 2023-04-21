//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lconst/model/my_encryption.dart';
import 'package:lconst/model/user_model.dart';
import 'package:lconst/screens/additional_doc.dart';
import 'package:lconst/screens/instructions.dart';
import 'package:lconst/screens/progress_up.dart';

import 'package:lconst/screens/your_profile.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  //loading indicator
  bool loadingprogress = false;
  bool loadingprogress2 = false;
  bool loadingprogress3 = false;
  var fName, fNameDec;

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
      setState(() {
        fName = MyEncryptionDecryption.decryptionAES(loggedInUser.firstName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      loadingprogress = false;
      loadingprogress2 = false;
      loadingprogress3 = false;
    });
    //**************************************************************************** */
    //sign up button
    final regUserButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      //button color
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          setState(() {
            loadingprogress = true;
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => YourProfile()));
          setState(() {
            loadingprogress = false;
          });
        },
        child: const Text(
          'Your Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    //Enter your progress photos
    //**************************************************************************** */
    //progress photos button
    final consPhotosButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      //button color
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          setState(() {
            loadingprogress2 = true;
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProgressUpload()));
        },
        child: const Text(
          'Your Progress Photos',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    //***************************************************************************** */
    //Additional documents button
    final additionalDocButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      //button color
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          setState(() {
            loadingprogress3 = true;
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AdditionalDoc()));
          setState(() {
            loadingprogress = false;
          });
        },
        child: const Text(
          'Add Additional Documents',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    //main build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Welcome ${fName}',
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/background2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              //margin: const EdgeInsets.all(30),
              //color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //top logo of the bank
                    SizedBox(
                      height: 200,
                      child: Image.asset('images/logom.png'),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    loadingprogress
                        ? const CircularProgressIndicator(
                            color: Colors.amber,
                            backgroundColor: Color.fromARGB(255, 243, 240, 240),
                            strokeWidth: 5.0,
                          )
                        : regUserButton,
                    const SizedBox(
                      height: 20.0,
                    ),
                    loadingprogress2
                        ? const CircularProgressIndicator(
                            color: Colors.amber,
                            backgroundColor: Color.fromARGB(255, 243, 240, 240),
                            strokeWidth: 5.0,
                          )
                        : consPhotosButton,
                    const SizedBox(
                      height: 20.0,
                    ),
                    loadingprogress3
                        ? const CircularProgressIndicator(
                            color: Colors.amber,
                            backgroundColor: Color.fromARGB(255, 243, 240, 240),
                            strokeWidth: 5.0,
                          )
                        : additionalDocButton,
                    const SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Want to know the process? ",
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Instructions()));
                          },
                          child: const Text(
                            'Instructions!',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //sign out line
                    const SizedBox(
                      height: 60.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            logout(context);
                            /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen()));*/
                          },
                          child: loadingprogress
                              ? const CircularProgressIndicator(
                                  color: Colors.amber,
                                  backgroundColor:
                                      Color.fromARGB(255, 243, 240, 240),
                                  strokeWidth: 5.0,
                                )
                              : const Text(
                                  'Sign Out',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> logout(BuildContext context) async {
    setState(() {
      loadingprogress = true;
    });
    await FirebaseAuth.instance.signOut();
    setState(() {
      loadingprogress = false;
    });
    Navigator.pushReplacement((context),
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}

import'package:flutter/material.dart';
import 'package:login_signup/signin.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData extends StatefulWidget {
  const UserData({ Key? key }) : super(key: key);

  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text(Get.arguments.toString()),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              size: 25.0,
            ),
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SigninPage()),
              );
            },
            
          ),
        ],
      ),
      drawer: Drawer(),
    );
  }
}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_signup/signin.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => SigninPage())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFAD6D0C),
                Color(0xFFFFB342),
              ],
            ),
          ),
          child: Center(
            child: Icon(
                Icons.sports_cricket,
                size: 150.0,
                color: Colors.white,
              ),
          ),
        ),
    );
  }
}
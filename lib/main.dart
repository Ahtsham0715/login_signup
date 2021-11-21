// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_signup/signin.dart';
// PAT = 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
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
              begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,                // ignore: prefer_const_literals_to_create_immutables
                // ignore: prefer_const_literals_to_create_immutables
                colors: [
                  Color(0xFFF16900),
                  Color(0xFFF28410),
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
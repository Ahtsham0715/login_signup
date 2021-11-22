// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_signup/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  var db = FirebaseFirestore.instance;

  Widget customtextfield(
      label_text, controller_name, validator_func, prefix_icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: TextFormField(
        controller: controller_name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator_func,
        decoration: InputDecoration(
          isDense: true,
          // counterText: "",
          contentPadding: EdgeInsets.all(10.0),
          filled: true,
          fillColor: Colors.white,
          label: Text(label_text),
          prefixIcon: prefix_icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                // ignore: prefer_const_literals_to_create_immutables
                colors: [
                  Color(0xFFF16900),
                  Color(0xFFF28410),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70.0),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.sports_cricket,
                  color: Colors.white,
                  size: 50.0,
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.04,
                  right: MediaQuery.of(context).size.width * 0.1,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Form(
            key: _formkey,
            child: Column(
              children: [
                customtextfield(
                  'Username',
                  _username,
                  (_val) {
                    if (_val!.isEmpty) {
                      return 'Username Required';
                    }
                  },
                  Icon(
                    Icons.person,
                  ),
                ),
                customtextfield(
                  'Password',
                  _password,
                  (_val) {
                    if (_val!.isEmpty) {
                      return 'Password Required';
                    }
                  },
                  Icon(
                    Icons.lock,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.09,
          ),
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                    // ignore: prefer_const_literals_to_create_immutables
                    colors: [
                      Color(0xFFF16900),
                      Color(0xFFF28410),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(70.0),
                ),
                child: MaterialButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      print('validated');
                    }
                  },
                  shape: StadiumBorder(),
                  child: Text(
                    'SignIn',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.09,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have account?",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFF16900),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

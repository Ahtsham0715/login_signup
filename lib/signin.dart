// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_signup/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_signup/user_record.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  Widget customtextfield(
      label_text, controller_name, validator_func, prefix_icon, ispassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: TextFormField(
        controller: controller_name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator_func,
        obscureText: ispassword,
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

  void customsnackbar(content_widget, action_lbl, action_func) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: content_widget,
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
        label: action_lbl,
        onPressed: action_func,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
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
                bottomLeft: Radius.circular(0.0),
              ),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  child: Icon(
                    Icons.sports_cricket,
                    color: Colors.white,
                    size: 120.0,
                  ),
                ),
                
              ],
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                color: Colors.white,
              ),
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Form(
            key: _formkey,
            child: Column(
              children: [
                customtextfield(
                  'Email',
                  _email,
                  (_val) {
                    if (_val!.isEmpty) {
                      return 'Username Required';
                    }
                    if (!RegExp(
                            r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                        .hasMatch(_email.text)) {
                      return 'Enter valid email';
                    }
                  },
                  Icon(
                    Icons.person,
                  ),
                  false

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
                  true
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
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(

              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10.0,
                    color: Color(0xFFF5B98B),
                    spreadRadius: 1.0,
                    offset: Offset(0.2, 3.0),
                  ),
                ],
                gradient: LinearGradient(
                  begin: FractionalOffset.centerLeft,
                  end: FractionalOffset.centerRight,
                  colors: [
                    Color(0xFFF16900),
                    Color(0xFFF28410),
                  ],
                ),
                borderRadius: BorderRadius.circular(70.0),
              ),
              child: MaterialButton(
                onPressed: () async {
                  if(_formkey.currentState!.validate()){
                    try {
                   UserCredential usercredentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _email.text,
                      password: _password.text,
                    );
                    User? username = usercredentials.user;

                    Get.to(
                      UserData(),
                      // arguments: username!.displayName,
                    );
                      Get.snackbar('Success', 'Logged In');
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      Get.snackbar('Unknown User', 'Please enter valid email');
                    } else if (e.code == 'wrong-password') {
                      Get.snackbar('Wrong Password', 'Password not matched');
                    }
                  }
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
            height: MediaQuery.of(context).size.height * 0.03,
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
            ),
          ),
        ],
      ),
    );
  }
}

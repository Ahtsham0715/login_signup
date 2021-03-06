// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_signup/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_signup/user_record.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController _fullname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  Widget customtextfield(
      label_text, controller_name, validator_func, prefix_icon, IsPassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        controller: controller_name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator_func,
        obscureText: IsPassword,
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

  void customsnackbar(content_widget, action_lbl) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: content_widget,
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
        label: action_lbl,
        onPressed: () {},
      ),
    ));
  }

  Future<bool> usernameCheck(String username) async {
    final result = await FirebaseFirestore.instance
        .collection('Users')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
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
                    'Register',
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
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Form(
            key: _formkey,
            child: Column(
              children: [
                customtextfield(
                  'Full Name',
                  _fullname,
                  (_val) {
                    if (_val!.isEmpty) {
                      return 'Fullname Required';
                    }
                  },
                  Icon(
                    Icons.person,
                  ),
                  false,
                ),
                customtextfield(
                  'Email',
                  _email,
                  (_val) {
                    if (_val!.isEmpty) {
                      return 'Email Required';
                    }
                    if (!RegExp(
                            r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                        .hasMatch(_email.text)) {
                      return 'Enter valid email';
                    }
                  },
                  Icon(
                    Icons.email,
                  ),
                  false,
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
                    Icons.vpn_key,
                  ),
                  true,
                ),
                customtextfield(
                  'Confirm Password',
                  _confirmpassword,
                  (_val) {
                    if (_val!.isEmpty) {
                      return 'Password Required';
                    }
                    if (_val != _password.text) {
                      return 'Both passwords not matched';
                    }
                  },
                  Icon(
                    Icons.vpn_key,
                  ),
                  true,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
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
                onPressed: () async {
                 try{
                   UserCredential usercrediantials =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                     email: _email.text,
                     password: _password.text,
                   );

                   User? thisuser = usercrediantials.user;
                   thisuser!.updateDisplayName(_fullname.text);
                  //  FirebaseAuth.instance.signOut();
                     Get.snackbar('Success', 'Account Created Successfully');
                     Get.to(UserData());
                     FirebaseAuth.instance.authStateChanges().listen((User? user) {
                       if(user == null){
                         Get.snackbar('user', 'User is currently Signed out');
                       }else{
                         Get.snackbar('user', 'User is currently Signed in');
                         
                       }
                     });
                 } on FirebaseAuthException catch(e){
                   if(e.code == 'weak-password'){
                     Get.snackbar('Error', 'Password is too weak');
                   }else if (e.code == 'email-already-in-use'){
                     Get.snackbar('Error', 'Email Already Exists');
                   } 
                 } catch (e){
                     Get.snackbar('Error', '$e');
                 }
                },
                shape: StadiumBorder(),
                child: Text(
                  'Register',
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
            height: MediaQuery.of(context).size.height * 0.065,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already a member?",
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
                      builder: (context) => SigninPage(),
                    ),
                  );
                },
                child: Text(
                  'Login',
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

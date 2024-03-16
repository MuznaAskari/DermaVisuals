import 'package:DermaVisuals/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:DermaVisuals/Controller/signup_controller.dart';
import 'package:DermaVisuals/Login/Signup.dart';
import 'package:get/get.dart';
import 'package:DermaVisuals/Login/Signup_with_phone.dart';
import 'package:DermaVisuals/Users/User.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Login_option_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(SignupController());
  final _LoginformKey = GlobalKey<FormState>();
  bool _obscureText = true;
  void toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/login-background.png"),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  height: 600,
                  width: 350,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.brown[50],

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _LoginformKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: controller.email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'User email',
                              icon: Icon(Icons.mail_outline),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                            width: 10,
                          ),
                          TextField(
                            controller: controller.password,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              hintText: 'User Password',
                              icon: InkWell(
                                onTap: () {
                                  toggle();
                                },
                                child: Icon(Icons.remove_red_eye_rounded),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                            width: 10,
                          ),

                          InkWell(
                            onTap: () {
                              SignupController.instance
                                  .forgetPassword(controller.email.text.trim());
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup_phone()));
                            },
                            child: Text(
                              'Login with phone?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              print(_LoginformKey.currentState);
                              if (_LoginformKey.currentState != null &&
                                  _LoginformKey.currentState!.validate()) {
                                SignupController.instance.LoginUser(
                                    controller.email.text.trim(),
                                    controller.password.text.trim(),
                                    selectedTabName);
                              }
                            },
                            child: Container(
                              width: 300,
                              height: 50,
                              child: Center(
                                child: Text(
                                    'Login',
                                    style: GoogleFonts.alkatra(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow[50]
                                    ),

                                  ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.brown[700]!,
                                    Color(0xFFA86A44),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()));
                            },
                            child: Container(
                              width: 300,
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Signup',
                                  style: GoogleFonts.alkatra(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow[50]
                                ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.brown[700]!,
                                    Color(0xFFA86A44),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
